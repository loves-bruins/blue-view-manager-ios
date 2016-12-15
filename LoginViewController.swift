//
//  SignupOrLoginViewController.swift
//  BlueViewManager
//
//  Created by Loren Rogers on 12/2/16.
//  Copyright © 2016 Loren Rogers. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    var user : FIRUser?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.hidesBackButton = true;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
        
    @IBAction func onSignIn(_ sender: AnyObject) {
        if let email = self.emailField.text, let password = self.passwordField.text {
            self.showSpinner({
                // [START headless_email_auth]
                FIRAuth.auth()?.signIn(withEmail: email, password: password) { (user, error) in
                    // [START_EXCLUDE]
                    self.hideSpinner({
                        if let error = error {
                            self.showMessagePrompt(error.localizedDescription)
                            return
                        }
                        self.user = user
                        self.navigationController!.popViewController(animated: true)
                    })
                    // [END_EXCLUDE]
                }
                // [END headless_email_auth]
            })
        } else {
            self.showMessagePrompt("email/password can't be empty")
        }
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
