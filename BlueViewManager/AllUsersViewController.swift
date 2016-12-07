//
//  AllUsersTableViewController.swift
//  BlueViewManager
//
//  Created by Loren Rogers on 12/6/16.
//  Copyright © 2016 Loren Rogers. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabaseUI

class AllUsersViewController: UIViewController, UITableViewDelegate {
    // [START define_database_reference]
    var ref: FIRDatabaseReference!
    // [END define_database_reference]
  
    @IBOutlet weak var tableView: UITableView!
  
    var dataSource: FirebaseTableViewDataSource?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // [START create_database_reference]
        ref = FIRDatabase.database().reference()
        // [END create_database_reference]
        
        dataSource = FirebaseTableViewDataSource.init(query: getQuery(),
                                                      modelClass: User.self,
                                                      nibNamed: "UserCell",
                                                      cellReuseIdentifier: "UserCell",
                                                      view: self.tableView)
        
        dataSource?.populateCell() {
            guard let cell = $0 as? UserTableViewCell else {
                return
            }
            guard let user = $1 as? User else {
                return
            }
            cell.username.text = user.userName
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
        return 150
    }
    
    func getUid() -> String {
        return (FIRAuth.auth()?.currentUser?.uid)!
    }
    
    func getQuery() -> FIRDatabaseQuery {
        return self.ref
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let path: IndexPath = sender as? IndexPath else { return }
        guard let detail: AllUsersViewController = segue.destination as? AllUsersViewController else {
            return
        }
        let source = self.dataSource
        guard let snapshot: FIRDataSnapshot = (source?.object(at: UInt((path as NSIndexPath).row)))! as? FIRDataSnapshot else {
            return
        }
        //detail.postKey = snapshot.key
    }
}
