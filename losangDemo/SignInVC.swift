//
//  SignInVC.swift
//  losangDemo
//
//  Created by SixSquarePC5 on 04/02/17.
//  Copyright © 2017 SixSquare Technologies. All rights reserved.
//

import UIKit

class SignInVC: UIViewController {

    @IBOutlet weak var signInBtn: UIButton!
    @IBOutlet weak var accountBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

         self.accountBtn.titleLabel?.attributedText = addBoldText(fullString: "DON'T HAVE AN ACCOUNT? SIGN UP", boldPartOfString: "SIGN UP", font: UIFont(name: "Avenir", size: 14), boldFont: UIFont(name: "Avenir-Heavy", size: 14)!)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addBoldText(fullString: NSString, boldPartOfString: NSString, font: UIFont!, boldFont: UIFont!) -> NSAttributedString {
        let nonBoldFontAttribute = [NSFontAttributeName:font!]
        let boldFontAttribute = [NSFontAttributeName:boldFont!]
        let boldString = NSMutableAttributedString(string: fullString as String, attributes:nonBoldFontAttribute)
        boldString.addAttributes(boldFontAttribute, range: fullString.range(of: boldPartOfString as String))
        return boldString
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
