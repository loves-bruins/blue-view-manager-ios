//
//  MasterViewController.swift
//  BlueViewManager
//
//  Created by Loren Rogers on 12/2/16.
//  Copyright © 2016 Loren Rogers. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var ref: FIRDatabaseReference!
    
    @IBAction func signOut(_ sender: AnyObject) {
        do {
            try FIRAuth.auth()?.signOut()
            navigationController?.popViewController(animated: true)
        }
        catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let newTitleView = MasterTitleView.init(frame: CGRect(x: 0, y: 0, width: self.view.frame.width - 45, height:45))
        
        let firebaseAuth = FIRAuth.auth();
        if(firebaseAuth?.currentUser == nil) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            self.navigationController?.pushViewController(loginVC, animated: true)
        }
        else
        {
            // Display logged in user
            if let user = firebaseAuth?.currentUser {
                (newTitleView.view as! MasterTitleView).loggedInUser?.text = user.email
                self.ref = FIRDatabase.database().reference()
                
                let changeRequest = user.profileChangeRequest()
                let username = user.email
                changeRequest.displayName = username
                
                // Commit profile changes to server
                changeRequest.commitChanges()
                { (error) in
                    if let error = error {
                        self.showMessagePrompt(error.localizedDescription)
                        return
                    }
                    
                    // [START basic_write]
                    let bridgedString = NSString(string:username!)
                    self.ref.child("users").child(user.uid).setValue(["userName": bridgedString])
                    // [END basic_write]
                }
            }
            
        }
        navigationItem.titleView = newTitleView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
//            if let indexPath = self.tableView.indexPathForSelectedRow {
//                let object = objects[indexPath.row] as! NSDate
//                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
//                controller.detailItem = object
//                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
//                controller.navigationItem.leftItemsSupplementBackButton = true
//            }
        }
    }
}

