//
//  EmployeeProfileTVC.swift
//  losangDemo
//
//  Created by SixSquarePC5 on 06/02/17.
//  Copyright © 2017 SixSquare Technologies. All rights reserved.
//

import UIKit

class EmployeeProfileTVC: UITableViewController,UIViewControllerTransitioningDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var profilePic: UIImageView!
    
     let customPresentAnimationController = CustomPresentAnimationController()
    let picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = UIColor.white
        self.title = "Profile"
        profilePic.layer.cornerRadius = 0.5 *  profilePic.bounds.size.width
        profilePic.clipsToBounds = true
        profilePic.layer.borderColor = UIColor.lightGray.cgColor
        profilePic.layer.borderWidth = 0.5
        
        let menuButton = UIBarButtonItem(image: UIImage(named:"menu"), style: .plain, target: self, action: #selector(EmployeeProfileTVC.menuClick))
        navigationItem.leftBarButtonItem = menuButton
        let doneButton = UIBarButtonItem(image: #imageLiteral(resourceName: "checkRed"), style: .plain, target: self, action:  #selector(EmployeeProfileTVC.doneClick(_:)))
        navigationItem.rightBarButtonItem = doneButton
        
        picker.delegate = self
    }

    func menuClick(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "profileToMenu", sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func doneClick(_ sender: UIBarButtonItem) {
       
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
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
        if segue.identifier == "profileToMenu" {
            let toViewController = segue.destination as UIViewController
            toViewController.transitioningDelegate = self
        }
    }

}
