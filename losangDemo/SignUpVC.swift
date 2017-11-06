//
//  SignUpVC.swift
//  losangDemo
//
//  Created by SixSquarePC5 on 04/02/17.
//  Copyright © 2017 SixSquare Technologies. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var alreadyBtn: UIButton!
    @IBOutlet weak var addImage: UIButton!
    
    let picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profilePic.layer.cornerRadius = 0.5 *  profilePic.bounds.size.width
        profilePic.clipsToBounds = true
        profilePic.layer.borderColor = UIColor.lightGray.cgColor
        profilePic.layer.borderWidth = 0.5
        
        self.alreadyBtn.titleLabel?.attributedText = addBoldText(fullString: "ALREADY HAVE AN ACCOUNT? SIGN IN", boldPartOfString: "SIGN IN", font: UIFont(name: "Avenir", size: 13), boldFont: UIFont(name: "Avenir-Heavy", size: 13)!)
        
        picker.delegate = self
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
    
    // MARK: - Picker Delegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            profilePic.image = image
        } else{
            print("Something went wrong")
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func choosePicClick(_ sender: UIButton) {
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        self.present(picker, animated: true, completion: nil)
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
