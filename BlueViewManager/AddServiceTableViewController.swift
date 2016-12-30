//
//  AddServiceTableViewController.swift
//  BlueViewManager
//
//  Created by Loren Rogers on 12/22/16.
//  Copyright © 2016 Loren Rogers. All rights reserved.
//

import UIKit

class AddServiceTableViewController: UITableViewController {

    @IBOutlet weak var notes: UITextField!
    @IBOutlet weak var date: UIDatePicker!
    @IBOutlet weak var price: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        self.navigationItem.title = "New Water Change"
        let addButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(newWaterChange))
        
        self.navigationItem.rightBarButtonItem = addButton
   }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func newWaterChange() {
        
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
