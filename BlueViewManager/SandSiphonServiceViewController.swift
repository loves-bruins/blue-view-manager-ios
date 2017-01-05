//
//  SandSiphonServiceViewController.swift
//  BlueViewManager
//
//  Created by Loren Rogers on 1/4/17.
//  Copyright © 2017 Loren Rogers. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabaseUI

class SandSiphonServiceViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var userId : String!
    var services = [Service]()
    let service_id = "dcd0e180-13a1-4b01-ba56-4e7bbd4a07e5"
    
    // [START define_database_reference]
    var ref: FIRDatabaseReference!
    // [END define_database_reference]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // [START create_database_reference]
        ref = FIRDatabase.database().reference()
        // [END create_database_reference]
        
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addSandSiphon))
        
        self.tabBarController?.navigationItem.rightBarButtonItem = addButton
        
        self.tabBarController?.navigationItem.title = "Sand Siphon"
        
        services.removeAll()
        
        let newRef = ref?.child("user_services").child(userId).child(service_id).queryOrderedByKey()
        newRef?.observe(.value, with: { snapshot in
            print(snapshot.value)
            if let snapshots = snapshot.children.allObjects as? [FIRDataSnapshot] {
                for snap in snapshots {
                    if let dict = snap.value as? Dictionary<String, AnyObject> {
                        var dateAsMlllis = Int64(0)
                        if let val = dict["date"] as? NSNumber {
                            dateAsMlllis = val.int64Value // This is an `Int64`
                        }
                        let service = Service(service_id: self.service_id, uid: self.userId, title: "Sand Siphon", price: dict["price"] as! Double, date: dateAsMlllis, notes: dict["notes"] as! String)
                        self.services.append(service)
                        
                    }
                }
                self.tableView.reloadData()
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Show the 'Add Service' screen
    func addSandSiphon() {
        performSegue(withIdentifier: "showAddService", sender: self)
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let dest = segue.destination as! AddServiceTableViewController
        dest.service_id = self.service_id
    }
    
    
}

extension SandSiphonServiceViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return services.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sand_siphon_cell", for: indexPath) as! SandSiphonCell
        cell.configureForService(services[indexPath.row])
        return cell
    }
    
}

// Mark: Table View Delegate

extension SandSiphonServiceViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 225
    }
}


class SandSiphonCell: UITableViewCell {
    
    @IBOutlet weak var notes: VerticalTopAlignLabel!
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
