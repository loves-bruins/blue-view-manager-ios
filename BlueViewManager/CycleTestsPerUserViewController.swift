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

    var userId : String!
    
    // [START define_database_reference]
    var ref: FIRDatabaseReference!
    // [END define_database_reference]
        
    var dataSource: FirebaseTableViewDataSource?
    
    @IBAction func onAddCycleTest (segue : UIStoryboardSegue)
    {
        if let vc = segue.source as? AddCycleTestTableViewController {
            let dateFormatter = DateFormatter.init()
            dateFormatter.dateStyle = .medium
            let dateString = dateFormatter.string(from: vc.date.date)
            let keys = ["ammonia" : (vc.ammonia.text! as NSString).doubleValue,
                        "date" : NSString(string:dateString),
                        "nitrate" : (vc.nitrate.text! as NSString).doubleValue,
                        "nitrite" : (vc.nitrite.text! as NSString).doubleValue,
                        "notes" : NSString(string:vc.notes.text!) ] as [String : Any]
            
            // Add the cycle-test params to the json database for this user
            //ref?.child("tests").child(userId!).child("cycle_tests").setValuesForKeys(keys)
         
            let newRef = ref?.child("tests").child(userId!).child("cycle_tests").queryOrderedByKey()
            let key = ref?.child("tests").child(userId!).child("cycle_tests").childByAutoId().key
            let userID = self.userId
            newRef?.observe(.value, with: { snapshot in
                print(snapshot.value)
                var tests = [CycleTest]()
                if let snapshots = snapshot.children.allObjects as? [FIRDataSnapshot] {
                    for snap in snapshots {
                        if let dict = snap.value as? Dictionary<String, AnyObject> {
                            let test = CycleTest()
                            test.setValuesForKeys(dict)
                            tests.append(test)
                        }
                    }
                    let childUpdates = ["/cycle_tests/\(key)/": keys]
                    self.ref?.child("tests").child(userID!).updateChildValues(childUpdates)
                }
            })
            
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // [START create_database_reference]
        ref = FIRDatabase.database().reference()
        // [END create_database_reference]
        
        dataSource = FirebaseTableViewDataSource.init(query: getQuery(),
                                                      modelClass: CycleTest.self,
                                                      nibNamed: "CycleTestTableViewCell",
                                                      cellReuseIdentifier: "cycle_test",
                                                      view: self.tableView)
        
        dataSource?.populateCell() {
            guard let cell = $0 as? CycleTestTableViewCell else {
                return
            }
            guard let test = $1 as? CycleTest else {
                return
            }
            
            cell.date.text = test.date
            cell.ammoniaLevel.text = String(format:"%0.03f", test.ammonia)
            cell.nitrateLevel.text = String(format:"%0.03f", test.nitrate)
            cell.nitriteLevel.text = String(format:"%0.03f", test.nitrite)
            cell.notes.text = test.notes
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
        
        return 211// CGFloat((dataSource?.items.count)!)
    }
    
    func getUid() -> String {
        return (FIRAuth.auth()?.currentUser?.uid)!
    }
    
    func getQuery() -> FIRDatabaseQuery {
        let usersQuery = (ref?.child("tests").child(userId!).child("cycle_tests").queryLimited(toFirst: 100))!
        return usersQuery
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
}
