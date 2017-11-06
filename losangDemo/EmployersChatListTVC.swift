//
//  EmployersChatListTVC.swift
//  losangDemo
//
//  Created by SixSquarePC5 on 06/02/17.
//  Copyright © 2017 SixSquare Technologies. All rights reserved.
//

import UIKit
import SWSegmentedControl

class EmployersChatListTVC: UITableViewController,UISearchBarDelegate,UIViewControllerTransitioningDelegate {

    @IBOutlet weak var segmentedControl: SWSegmentedControl!
    @IBOutlet weak var segmentView: UIView!
    
    var selectedIndex = 0
    var searchBar = UISearchBar()
    var searchButton : UIBarButtonItem?
    let customPresentAnimationController = CustomPresentAnimationController()
    
       override func viewDidLoad() {
        super.viewDidLoad()
        

        self.title = "Chat"
        
        let sc2 = SWSegmentedControl(items: ["RECENT", "ALL CONTACTS"])
        sc2.selectedSegmentIndex = 0
        sc2.titleColor = UIColor.white
        sc2.unselectedTitleColor = UIColor.white
        sc2.indicatorColor = UIColor.white
        sc2.translatesAutoresizingMaskIntoConstraints = false
        sc2.addTarget(self, action: #selector(EmployersChatListTVC.segmentChanged(_:)), for: .valueChanged)
        segmentView.addSubview(sc2)
        segmentView.isUserInteractionEnabled = true
        
        let constraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|[sc2]|", options: [], metrics: nil, views: ["sc2": sc2])
        NSLayoutConstraint.activate(constraints)
        
        let constraints2 = NSLayoutConstraint.constraints(withVisualFormat: "V:[sc2(44)]", options: [], metrics: nil, views: ["sc2": sc2])
        NSLayoutConstraint.activate(constraints2)
        
        let centerY = NSLayoutConstraint(item: sc2, attribute: .centerY, relatedBy: .equal, toItem: self.segmentView, attribute: .centerY, multiplier: 1, constant: 0)
        self.segmentView.addConstraint(centerY)
        
        let menuButton = UIBarButtonItem(image: UIImage(named:"menu"), style: .plain, target: self, action: #selector(EmployersChatListTVC.menuClick))
        navigationItem.leftBarButtonItem = menuButton
        
         self.searchButton = UIBarButtonItem(image: #imageLiteral(resourceName: "search"), style: .plain, target: self, action: #selector(EmployersChatListTVC.searchClick(_:)))
        searchBar.showsCancelButton = true
        navigationItem.rightBarButtonItem = self.searchButton
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        searchBar.delegate = self
        searchBar.searchBarStyle = UISearchBarStyle.minimal
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func menuClick(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "chatToMenu", sender: self)
    }
    
    func searchClick(_ sender: UIBarButtonItem) {
        showSearchBar()
    }
    
    func showSearchBar() {
        searchBar.alpha = 0
        navigationItem.titleView = searchBar
        navigationItem.setRightBarButton(nil, animated: true)
        UIView.animate(withDuration: 0.5, animations: {
            self.searchBar.alpha = 1
        }, completion: { finished in
            self.searchBar.becomeFirstResponder()
        })
    }
    
    func hideSearchBar() {
        navigationItem.setRightBarButton(searchButton, animated: true)
        self.navigationItem.titleView = nil
        UIView.animate(withDuration: 0.3, animations: {
            self.navigationItem.title = "Chat"
            }, completion: { finished in
            
        })
    }
    
    //MARK: UISearchBarDelegate
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        hideSearchBar()
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if selectedIndex == 0 {
            return  5
        }
        else {
            return 10
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if selectedIndex == 0 {
             let cell = tableView.dequeueReusableCell(withIdentifier: "RecentCell", for: indexPath) as! ChatListRecentTVCell
            cell.recentBtn.layer.cornerRadius = 0.5 *  cell.recentBtn.bounds.size.width
            cell.recentBtn.clipsToBounds = true
            return cell
        }
        
        else {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatListCell", for: indexPath) as! EmployerChatListTVCell

        cell.chatImage.layer.cornerRadius = 0.5 *  cell.chatImage.bounds.size.width
        cell.chatImage.clipsToBounds = true
        cell.chatImage.layer.borderColor = UIColor.black.cgColor
        cell.chatImage.layer.borderWidth = 0.5
        // Configure the cell...
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
    func segmentChanged(_ sender: SWSegmentedControl) {
        print("select: \(sender.selectedSegmentIndex)")
        selectedIndex = sender.selectedSegmentIndex
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return customPresentAnimationController
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "chatToMenu" {
            let toViewController = segue.destination as UIViewController
            toViewController.transitioningDelegate = self
        }
    }
}
