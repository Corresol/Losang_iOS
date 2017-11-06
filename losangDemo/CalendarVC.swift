//
//  CalendarVC.swift
//  losangDemo
//
//  Created by SixSquarePC5 on 06/02/17.
//  Copyright © 2017 SixSquare Technologies. All rights reserved.
//

import UIKit
import FSCalendar

class CalendarVC: UIViewController,FSCalendarDelegate,FSCalendarDataSource,UITableViewDataSource,UITableViewDelegate,UIViewControllerTransitioningDelegate {

    @IBOutlet weak var calendarView: FSCalendar!
    @IBOutlet weak var calendarHeightConstraint: NSLayoutConstraint!
    
    var screenSize: CGRect!
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    let customPresentAnimationController = CustomPresentAnimationController()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Calendar"
        screenSize = UIScreen.main.bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        calendarHeightConstraint.constant = screenHeight / 2
        
        calendarView.scrollDirection = .horizontal
        // Do any additional setup after loading the view.
        let menuButton = UIBarButtonItem(image: UIImage(named:"menu"), style: .plain, target: self, action: #selector(CalendarVC.menuClick))
        navigationItem.leftBarButtonItem = menuButton
        
        let doneButton = UIBarButtonItem(image:#imageLiteral(resourceName: "plusGrey"), style: .plain, target: self, action: #selector(CalendarVC.doneClick))
        navigationItem.rightBarButtonItem = doneButton
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func menuClick(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "calendarToMenu", sender: self)
    }
    
    func doneClick(_ sender: UIBarButtonItem) {
        
    }
    
    // MARK: - Table view data source
    
     func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }
    
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "calendatTableCell", for: indexPath) as! calendarTableViewCell
        // Configure the cell...
        cell.profileImage.layer.cornerRadius = 0.5 *  cell.profileImage.bounds.size.width
        cell.profileImage.clipsToBounds = true
        cell.profileImage.layer.borderColor = UIColor.black.cgColor
        cell.profileImage.layer.borderWidth = 0.5
        return cell
    }
    
    
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return customPresentAnimationController
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "projectToMenu" {
            let toViewController = segue.destination as UIViewController
            toViewController.transitioningDelegate = self
        }
    }

}
