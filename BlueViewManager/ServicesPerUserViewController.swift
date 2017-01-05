//
//  ServicesPerUserViewController.swift
//  BlueViewManager
//
//  Created by Loren Rogers on 12/14/16.
//  Copyright © 2016 Loren Rogers. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabaseUI

class ServicesPerUserViewController: UITabBarController, UITabBarControllerDelegate {
    @IBOutlet weak var tableView: UITableView!

    var userId : String!

    // [START define_database_reference]
    var ref: FIRDatabaseReference!
    // [END define_database_reference]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.delegate = self
        if let viewControllers = self.viewControllers {
            for viewController in viewControllers {
                if viewController is WaterChangeServiceViewController {
                    let vc = viewController as! WaterChangeServiceViewController
                    vc.userId = self.userId
                }
                else if viewController is AlgaeScrapeServiceViewController {
                    let vc = viewController as! AlgaeScrapeServiceViewController
                    vc.userId = self.userId
                }
            }
        }
        let vc = self.viewControllers?.first as! WaterChangeServiceViewController
        vc.userId = self.userId
        
        // [START create_database_reference]
        ref = FIRDatabase.database().reference()
        // [END create_database_reference]

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     * This will be the unwind segue handler for Water Change, Algae Scrape service addition
     */
    @IBAction func onAddService(_ segue: UIStoryboardSegue) {
        let sourceVC = segue.source as! AddServiceTableViewController
        let dateInMilliseconds = sourceVC.date.date.millisecondsSince1970
        var price : Double = 0.0
        if !(sourceVC.price.text?.isEmpty)! {
            price = Double(sourceVC.price.text!)!
        }
        let keys = ["date" : NSNumber(value:dateInMilliseconds),
                    "price" : NSNumber(value:price),
                    "notes" : NSString(string:sourceVC.notes.text!) ] as [String : Any]
        
        var childNode = ""
        if sourceVC.service_id == "0ef5b8bd-fabd-4d02-8f4c-b7362c2a6810" {
            childNode = "water_change"
        }
        else if sourceVC.service_id == "619d6018-7ff1-427d-9e2c-230512ac4760" {
            childNode = "algae_scrape"
        }
        
        let newRef = ref?.child("user_services").child(userId!).child(childNode).queryOrderedByKey()
        let key = ref?.child("user_services").child(userId!).child(childNode).childByAutoId().key
        let userID = self.userId
        newRef?.observe(.value, with: { snapshot in
            print(snapshot.value)
            if let snapshots = snapshot.children.allObjects as? [FIRDataSnapshot] {
                for snap in snapshots {
                    if let dict = snap.value as? Dictionary<String, AnyObject> {
                        let service = Service()
                        service.setValuesForKeys(dict)
                        //self.services.append(service)
                    }
                }
                if sourceVC.service_id == "0ef5b8bd-fabd-4d02-8f4c-b7362c2a6810" {
                    let childUpdates = ["/0ef5b8bd-fabd-4d02-8f4c-b7362c2a6810/\(key)/": keys]
                    self.ref?.child("user_services").child(userID!).updateChildValues(childUpdates)
                }
                else if sourceVC.service_id == "619d6018-7ff1-427d-9e2c-230512ac4760" {
                    let childUpdates = ["/619d6018-7ff1-427d-9e2c-230512ac4760/\(key)/": keys]
                    self.ref?.child("user_services").child(userID!).updateChildValues(childUpdates)
                }
            }
        })
        
        
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
//        if viewController is WaterChangeServiceViewController {
//            let vc = viewController as! WaterChangeServiceViewController
//            vc.userId = self.userId
//        }
//        else if viewController is AlgaeScrapeViewController {
//            let vc = viewController as! AlgaeScrapeViewController
//            vc.userId = self.userId
//        }
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

