//
//  HomeVC.swift
//  losangDemo
//
//  Created by SixSquarePC5 on 07/02/17.
//  Copyright © 2017 SixSquare Technologies. All rights reserved.
//

import UIKit
import SwiftCharts
//import Charts
let screenSize: CGRect = UIScreen.main.bounds
let defaults = UserDefaults.standard
class HomeVC: UIViewController,UITableViewDataSource,UITableViewDelegate,UIViewControllerTransitioningDelegate  {
    fileprivate var chart: Chart?
    
    @IBOutlet weak var chartView: UIView!
    fileprivate let dirSelectorHeight: CGFloat = 50
    
    fileprivate func barsChart(horizontal: Bool) -> Chart {
        let labelSettings = ChartLabelSettings(font: ExamplesDefaults.labelFont)
        
        let groupsData: [(title: String, [(min: Double, max: Double)])] = [
            ("A", [
                (0, 64),
                (0, 32),
                (0, 12)
                ])
            //,
//            ("B", [
//                (0, 20),
//                (0, 30),
//                (0, 25)
//                ]),
//            ("C", [
//                (0, 30),
//                (0, 50),
//                (0, 5)
//                ]),
//            ("D", [
//                (0, 55),
//                (0, 30),
//                (0, 25)
//                ])
        ]
      //  UIColor.cyan.withAlphaComponent(0.9)
        //UIColor.init(red: 95/255, green: 196/255, blue: 182/255, alpha: 1)
    //    UIColor.init(red: 147/255, green: 147/255, blue: 243/255, alpha: 1)
      //  UIColor.init(red: 252/255, green: 179/255, blue: 84/255, alpha: 1)
        let groupColors = [UIColor.init(red: 95/255, green: 196/255, blue: 182/255, alpha: 1),UIColor.init(red: 147/255, green: 147/255, blue: 243/255, alpha: 1), UIColor.init(red: 252/255, green: 179/255, blue: 84/255, alpha: 1)]
        
        let groups: [ChartPointsBarGroup] = groupsData.enumerated().map {index, entry in
            let constant = ChartAxisValueDouble(index)
            let bars = entry.1.enumerated().map {index, tuple in
                ChartBarModel(constant: constant, axisValue1: ChartAxisValueDouble(tuple.min), axisValue2: ChartAxisValueDouble(tuple.max), bgColor: groupColors[index])
            }
            return ChartPointsBarGroup(constant: constant, bars: bars)
        }
        
        let (axisValues1, axisValues2): ([ChartAxisValue], [ChartAxisValue]) = (
            stride(from: 0, through: 70, by: 10).map {ChartAxisValueDouble(Double($0), labelSettings: labelSettings)},
            [ChartAxisValueString(order: -1)] +
                groupsData.enumerated().map {index, tuple in ChartAxisValueString(tuple.0, order: index, labelSettings: labelSettings)} +
                [ChartAxisValueString(order: groupsData.count)]
        )
        let (xValues, yValues) = horizontal ? (axisValues1, axisValues2) : (axisValues2, axisValues1)
        
        let xModel = ChartAxisModel(axisValues: xValues, axisTitleLabel: ChartAxisLabel(text: "Axis title", settings: labelSettings))
        let yModel = ChartAxisModel(axisValues: yValues, axisTitleLabel: ChartAxisLabel(text: "Axis title", settings: labelSettings.defaultVertical()))
        let frame = ExamplesDefaults.chartFrame(chartView.bounds)
       
        let chartFrame = chart?.frame ?? CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.size.width, height: frame.size.height )
        
        let chartSettings = ExamplesDefaults.chartSettingsWithPanZoom
        
        let coordsSpace = ChartCoordsSpaceLeftBottomSingleAxis(chartSettings: chartSettings, chartFrame: chartFrame, xModel: xModel, yModel: yModel)
        let (xAxisLayer, yAxisLayer, innerFrame) = (coordsSpace.xAxisLayer, coordsSpace.yAxisLayer, coordsSpace.chartInnerFrame)
        
        let barViewSettings = ChartBarViewSettings(animDuration: 0.5, selectionViewUpdater: ChartViewSelectorBrightness(selectedFactor: 0.5))
        
        let groupsLayer = ChartGroupedPlainBarsLayer(xAxis: xAxisLayer.axis, yAxis: yAxisLayer.axis, groups: groups, horizontal: horizontal, barSpacing: 2, groupSpacing: 25, settings: barViewSettings, tapHandler: { tappedGroupBar /*ChartTappedGroupBar*/ in
            
            let barPoint = horizontal ? CGPoint(x: tappedGroupBar.tappedBar.view.frame.maxX, y: tappedGroupBar.tappedBar.view.frame.midY) : CGPoint(x: tappedGroupBar.tappedBar.view.frame.midX, y: tappedGroupBar.tappedBar.view.frame.minY)
            
            guard let chart = self.chart, let chartViewPoint = tappedGroupBar.layer.contentToGlobalCoordinates(barPoint) else {return}
            
            let viewPoint = CGPoint(x: chartViewPoint.x, y: chartViewPoint.y)
            
            let infoBubble = InfoBubble(point: viewPoint, preferredSize: CGSize(width: 50, height: 40), superview: self.chart!.view, text: tappedGroupBar.tappedBar.model.axisValue2.description, font: ExamplesDefaults.labelFont, textColor: UIColor.white, bgColor: UIColor.black, horizontal: horizontal)
            
            let anchor: CGPoint = {
                switch (horizontal, infoBubble.inverted(chart.view)) {
                case (true, true): return CGPoint(x: 1, y: 0.5)
                case (true, false): return CGPoint(x: 0, y: 0.5)
                case (false, true): return CGPoint(x: 0.5, y: 0)
                case (false, false): return CGPoint(x: 0.5, y: 1)
                }
            }()
            
            let animatorsSettings = ChartViewAnimatorsSettings(animInitSpringVelocity: 5)
            let animators = ChartViewAnimators(view: infoBubble, animators: ChartViewGrowAnimator(anchor: anchor), settings: animatorsSettings, invertSettings: animatorsSettings.withoutDamping(), onFinishInverts: {
                infoBubble.removeFromSuperview()
            })
            
            chart.view.addSubview(infoBubble)
            
            infoBubble.tapHandler = {
                animators.invert()
            }
            
            animators.animate()
        })
        
        let guidelinesSettings = ChartGuideLinesLayerSettings(linesColor: UIColor.clear, linesWidth: ExamplesDefaults.guidelinesWidth)
        let guidelinesLayer = ChartGuideLinesLayer(xAxisLayer: xAxisLayer, yAxisLayer: yAxisLayer, axis: horizontal ? .x : .y, settings: guidelinesSettings)
        
        return Chart(
            frame: chartFrame,
            innerFrame: innerFrame,
            settings: chartSettings,
            layers: [
                xAxisLayer,
                yAxisLayer,
                guidelinesLayer,
                groupsLayer
            ]
        )
    }
    
    
    fileprivate func showChart(horizontal: Bool) {
        self.chart?.clearView()
        
        let chart = barsChart(horizontal: horizontal)
        view.addSubview(chart.view)
        self.chart = chart
    }
    

var months1: [String]!

    @IBOutlet weak var tableView: UITableView!

    let customPresentAnimationController = CustomPresentAnimationController()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //BarsChartConfig
       //view.bringSubview(toFront: chartView)
       // chartView.superview?.bringSubview(toFront: chartView)
        let screenWidth = screenSize.width
        UserDefaults.standard.set(screenWidth, forKey: "screenW")
//        if screenWidth >= 768
//        {
            showChart(horizontal: true)

       // }
    
        self.title = "Home"
        let menuButton = UIBarButtonItem(image: UIImage(named:"menu"), style: .plain, target: self, action: #selector(HomeVC.menuClick))
        navigationItem.leftBarButtonItem = menuButton
        let notButton = UIBarButtonItem(image: #imageLiteral(resourceName: "notificationRed"), style: .plain, target: self, action: #selector(HomeVC.notClick))
        navigationItem.rightBarButtonItem = notButton
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func menuClick(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "homeToMenu", sender: self)
    }
    
    func notClick(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "homeToNotifications", sender: self)
    }

    // MARK: - Tableview functions
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return customPresentAnimationController
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "homeToMenu" {
            let toViewController = segue.destination as UIViewController
            toViewController.transitioningDelegate = self
        }
    }
    
    class DirSelector: UIView {
        
        let horizontal: UIButton
        let vertical: UIButton
        
        weak var controller: HomeVC?
        
        fileprivate let buttonDirs: [UIButton : Bool]
        
        init(frame: CGRect, controller: HomeVC) {
            
            self.controller = controller
            
            horizontal = UIButton()
            horizontal.setTitle("Horizontal", for: UIControlState())
            vertical = UIButton()
            vertical.setTitle("Vertical", for: UIControlState())
            
            buttonDirs = [horizontal : true, vertical : false]
            
            super.init(frame: frame)
            
            addSubview(horizontal)
            addSubview(vertical)
            
            for button in [horizontal, vertical] {
                button.titleLabel?.font = ExamplesDefaults.fontWithSize(14)
                button.setTitleColor(UIColor.blue, for: UIControlState())
                button.addTarget(self, action: #selector(DirSelector.buttonTapped(_:)), for: .touchUpInside)
            }
        }
        
        func buttonTapped(_ sender: UIButton) {
            let horizontal = sender == self.horizontal ? true : false
            controller?.showChart(horizontal: horizontal)
        }
        
        override func didMoveToSuperview() {
            let views = [horizontal, vertical]
            for v in views {
                v.translatesAutoresizingMaskIntoConstraints = false
            }
            
            let namedViews = views.enumerated().map{index, view in
                ("v\(index)", view)
            }
            
            var viewsDict = Dictionary<String, UIView>()
            for namedView in namedViews {
                viewsDict[namedView.0] = namedView.1
            }
            
            let buttonsSpace: CGFloat = Env.iPad ? 20 : 10
            
            let hConstraintStr = namedViews.reduce("H:|") {str, tuple in
                "\(str)-(\(buttonsSpace))-[\(tuple.0)]"
            }
            
            let vConstraits = namedViews.flatMap {NSLayoutConstraint.constraints(withVisualFormat: "V:|[\($0.0)]", options: NSLayoutFormatOptions(), metrics: nil, views: viewsDict)}
            
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: hConstraintStr, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDict)
                + vConstraits)
        }
        
        required init(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }

}
