//
//  SignupViewController.swift
//  BlueViewManager
//
//  Created by Loren Rogers on 12/3/16.
//  Copyright © 2016 Loren Rogers. All rights reserved.
//

import UIKit

class SignupViewController: UITableViewController {

    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var passwordVerifyField: UITextField!
    
    @IBOutlet weak var createButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        createButton.isEnabled = false;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func emailChanged(_ sender: AnyObject) {
        if(validate()) {
            createButton.isEnabled = true
        }
    }

    @IBAction func passwordChanged(_ sender: AnyObject) {
        if(validate()) {
            createButton.isEnabled = true
        }
    }
    @IBAction func passwordVerificationChanged(_ sender: AnyObject) {
        if(validate()) {
            createButton.isEnabled = true
        }
    }
    
    func validate() -> Bool
    {
        var valid = false
        if(isValidEmail(testStr: emailField.text!) && passwordField.text! == passwordVerifyField.text!) {
            valid = true;
        }
        return valid
    }
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let range = testStr.range(of:emailRegEx, options:.regularExpression)
        let result = range != nil ? true : false
        return result
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
