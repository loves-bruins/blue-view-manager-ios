//
//  CycleTestsPerUserViewController.swift
//  BlueViewManager
//
//  Created by Loren Rogers on 12/7/16.
//  Copyright © 2016 Loren Rogers. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabaseUI

class CycleTestsPerUserViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!

    var key : String!
    
    // [START define_database_reference]
    var ref: FIRDatabaseReference!
    // [END define_database_reference]
        
    var dataSource: FirebaseTableViewDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // [START create_database_reference]
        ref = FIRDatabase.database().reference()
        // [END create_database_reference]
        self.tableView.register(UINib(nibName: "CycleTestTableViewCell", bundle: nil), forCellReuseIdentifier: "cycle_test")
        
        dataSource = FirebaseTableViewDataSource.init(query: getQuery(),
                                                      modelClass: CycleTest.self,
                                                      nibNamed: "CycleTestTableViewCell",
                                                      cellReuseIdentifier: "cycle_test",
                                                      view: self.tableView)
        
        dataSource?.populateCell() {
            guard let cell = $0 as? CycleTestTableViewCell else {
                return
            }
            guard let user = $1 as? CycleTest else {
                return
            }
        }
        
        tableView.dataSource = dataSource
        tableView.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detail", sender: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func getUid() -> String {
        return (FIRAuth.auth()?.currentUser?.uid)!
    }
    
    func getQuery() -> FIRDatabaseQuery {
        let usersQuery = (ref?.child("users").child(key!).child("cycle_test").queryLimited(toFirst: 100))!
        return usersQuery
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
}
