//
//  UserHistoryTableViewController.swift
//  BlueViewManager
//
//  Created by Loren Rogers on 12/15/16.
//  Copyright © 2016 Loren Rogers. All rights reserved.
//

import UIKit

class UserHistoryTableViewController: UITableViewController {

    var userId : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCycleTests" {
            let dest = segue.destination as! CycleTestsPerUserViewController
            dest.userId = self.userId
        }
        else if segue.identifier == "showAllServices" {
            let dest = segue.destination as! ServicesPerUserViewController
            dest.userId = self.userId
        }
    }

}
