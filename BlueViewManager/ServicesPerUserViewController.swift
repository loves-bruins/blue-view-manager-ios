//
//  ServicesPerUserViewController.swift
//  BlueViewManager
//
//  Created by Loren Rogers on 12/14/16.
//  Copyright © 2016 Loren Rogers. All rights reserved.
//

import UIKit

class ServicesPerUserViewController: UITabBarController, UITabBarControllerDelegate {
    @IBOutlet weak var tableView: UITableView!

    var userId : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.delegate = self
        let vc = self.viewControllers?.first as! WaterChangeServiceViewController
        vc.userId = self.userId
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
        let dateInMilliseconds = Date().millisecondsSince1970
        let keys = ["date" : NSNumber(value:dateInMilliseconds),
                    "price" : NSNumber(value:24.00),
                    "service_id" : NSString(string:sourceVC.service_id),
                    "uid" : NSString(string:self.userId),
                    "notes" : NSString(string:sourceVC.notes.text!) ] as [String : Any]
        
//        let newRef = ref?.child("user_services").child(userId!).child("water_change").queryOrderedByKey()
//        let key = ref?.child("user_services").child(userId!).child("water_change").childByAutoId().key
//        let userID = self.userId
//        newRef?.observe(.value, with: { snapshot in
//            print(snapshot.value)
//            if let snapshots = snapshot.children.allObjects as? [FIRDataSnapshot] {
//                for snap in snapshots {
//                    if let dict = snap.value as? Dictionary<String, AnyObject> {
//                        let service = Service()
//                        service.setValuesForKeys(dict)
//                        self.services.append(service)
//                    }
//                }
//                let childUpdates = ["/water_change/\(key)/": keys]
//                self.ref?.child("user_services").child(userID!).updateChildValues(childUpdates)
//            }
//        })
        
        
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let vc = viewController as! WaterChangeServiceViewController
        vc.userId = self.userId
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


