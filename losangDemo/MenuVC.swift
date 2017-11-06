//
//  MenuVC.swift
//  losangDemo
//
//  Created by SixSquarePC5 on 10/02/17.
//  Copyright © 2017 SixSquare Technologies. All rights reserved.
//

import UIKit

class MenuVC: UIViewController {

    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var profilePic: UIImageView!
    
    var tbc : UITabBarController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        profilePic.layer.cornerRadius = 0.5 *  profilePic.bounds.size.width
        profilePic.clipsToBounds = true
        profilePic.layer.borderColor = UIColor.white.cgColor
        profilePic.layer.borderWidth = 0.5

         tbc = (self.storyboard?.instantiateViewController(withIdentifier: "HomeController"))! as? UITabBarController
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closeClick(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }

    @IBAction func profileClick(_ sender: UIButton) {
        tbc?.selectedIndex=1
        self.present(tbc!, animated: false, completion: nil)
    }
    @IBAction func homeClick(_ sender: UIButton) {
        tbc?.selectedIndex=0
        self.present(tbc!, animated: false, completion: nil)
    }
    
    @IBAction func chatClick(_ sender: UIButton) {
        tbc?.selectedIndex=2
        self.present(tbc!, animated: false, completion: nil)
    }
    
    @IBAction func projectClick(_ sender: UIButton) {
        tbc?.selectedIndex=3
        self.present(tbc!, animated: false, completion: nil)
    }
    
    @IBAction func calendarClick(_ sender: UIButton) {
        tbc?.selectedIndex=4
        self.present(tbc!, animated: false, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
