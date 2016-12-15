//
//  AddCycleTestTableViewController.swift
//  BlueViewManager
//
//  Created by Loren Rogers on 12/7/16.
//  Copyright © 2016 Loren Rogers. All rights reserved.
//

import UIKit

class AddCycleTestTableViewController: UITableViewController {
    @IBOutlet weak var date: UIDatePicker!
    @IBOutlet weak var ammonia: UITextField!
    @IBOutlet weak var notes: UITextField!

    @IBOutlet weak var nitrate: UITextField!
    @IBOutlet weak var nitrite: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        print (indexPath.section)
        if indexPath.section == 0 || indexPath.section == 4 {
            return 110
        }
        else {
            return 44
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
