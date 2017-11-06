//
//  HomeController.swift
//  losangDemo
//
//  Created by SixSquarePC5 on 07/02/17.
//  Copyright © 2017 SixSquare Technologies. All rights reserved.
//

import UIKit

class HomeController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.tabBar.barTintColor = UIColor.white
//        self.tabBar.unselectedItemTintColor = UIColor(red: 187.0/255.0, green: 34.0/255.0, blue: 33.0/255.0, alpha: 1.0)
//        self.tabBar.tintColor = UIColor(red: 51.0/255.0, green: 51.0/255.0, blue: 51.0/255.0, alpha: 1.0)
        
        if #available(iOS 10.0, *) {
            self.tabBar.unselectedItemTintColor = UIColor.white
        } else {
            // Fallback on earlier versions
            for item in self.tabBar.items! {
                item.image = item.selectedImage?.imageWithColor(color1: UIColor.white).withRenderingMode(UIImageRenderingMode.alwaysOriginal)
                //In case you wish to change the font color as well
                let attributes = [NSForegroundColorAttributeName: UIColor.white]
                item.setTitleTextAttributes(attributes, for: UIControlState.normal)
            }
        }
        self.tabBar.tintColor =  UIColor(red: 200.0/255.0, green: 57.0/255.0, blue: 63.0/255.0, alpha: 1.0)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
extension UIImage {
    func imageWithColor(color1: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        color1.setFill()
        
        let context = UIGraphicsGetCurrentContext()
        context!.translateBy(x: 0, y: self.size.height)
        context!.scaleBy(x: 1.0, y: -1.0);
        context!.setBlendMode(CGBlendMode.normal)
        
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        context!.clip(to: rect, mask: self.cgImage!)
        context!.fill(rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()! as UIImage
        UIGraphicsEndImageContext()
        
        return newImage
    }
}

