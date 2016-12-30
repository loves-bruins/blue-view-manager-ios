//
//  WaterChangeServiceViewController.swift
//  BlueViewManager
//
//  Created by Loren Rogers on 12/21/16.
//  Copyright © 2016 Loren Rogers. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabaseUI

class WaterChangeServiceViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    var userId : String!
    var services = [Service]()
    // [START define_database_reference]
    var ref: FIRDatabaseReference!
    // [END define_database_reference]

    @IBAction func onAddService(segue: UIStoryboardSegue) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.tabBarController?.navigationItem.title = "Water Change"
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addWaterChange))
        
        self.tabBarController?.navigationItem.rightBarButtonItem = addButton
        
        // [START create_database_reference]
        ref = FIRDatabase.database().reference()
        // [END create_database_reference]
        userId = "F259TA3LR7OmFBmE8FnMCMpN3NA2"
        
        let newRef = ref?.child("user_services").child(userId).queryOrderedByKey()
        newRef?.observe(.value, with: { snapshot in
            print(snapshot.value)
            if let snapshots = snapshot.children.allObjects as? [FIRDataSnapshot] {
                for snap in snapshots {
                    if let dict = snap.value as? Dictionary<String, AnyObject> {
                        for serviceValue in dict.values {
                            
                            var dateAsMlllis = Int64(0)
                            if let val = serviceValue["date"] as? NSNumber {
                                dateAsMlllis = val.int64Value // This is an `Int64`
                            }
                            let service = Service(service_id: "0ef5b8bd-fabd-4d02-8f4c-b7362c2a6810", uid: self.userId, title: "Water Change", price: serviceValue["price"] as! Double, date: dateAsMlllis, notes: serviceValue["notes"] as! String)
                            self.services.append(service)
                        }
                    }
                }
                self.tableView.reloadData()
            }
        })
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addWaterChange() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "AddServiceTableViewController") as! AddServiceTableViewController
        self.tabBarController?.navigationController?.pushViewController(vc, animated: true)
//        let dateInMilliseconds = Date().millisecondsSince1970
//        let keys = ["date" : NSNumber(value:dateInMilliseconds),
//                    "price" : NSNumber(value:24.00),
//                    "service_id" : NSString(string:"0ef5b8bd-fabd-4d02-8f4c-b7362c2a6810"),
//                    "uid" : NSString(string:self.userId),
//                    "notes" : NSString(string:"Initial tank setup.  Added 75 gallons") ] as [String : Any]
//        
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
//        
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

extension WaterChangeServiceViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return services.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "water_change_cell", for: indexPath) as! WaterChangeCell
        cell.configureForService(services[indexPath.row])
        return cell
    }
    
}

// Mark: Table View Delegate

extension WaterChangeServiceViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 225
    }
}

extension Date {
    var millisecondsSince1970:Int64 {
        return Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    
    init(milliseconds:Int) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds / 1000))
    }
}

class WaterChangeCell: UITableViewCell {

    @IBOutlet weak var notes: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var date: UILabel!

    func configureForService(_ service: Service) {
        price.text = String(service.price)
        notes.text = service.notes
        let theDate = Date(timeIntervalSince1970: TimeInterval(service.date / 1000))
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium

        date.text = dateFormatter.string(from: theDate)
    }
}
