//
//  SidePanelViewController.swift
//  BlueViewManager
//
//  Created by Loren Rogers on 12/15/16.
//  Copyright © 2016 Loren Rogers. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabaseUI

@objc
protocol SidePanelViewControllerDelegate {
    func typeSelected(_ service: Service)
}

class SidePanelViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var services: Array<Service>!

    // [START define_database_reference]
    var ref: FIRDatabaseReference!
    // [END define_database_reference]
    
    struct TableView {
        struct CellIdentifiers {
            static let ServiceTypeCell = "ServiceTypeCell"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // [START create_database_reference]
        ref = FIRDatabase.database().reference()
        // [END create_database_reference]

        let newRef = ref?.child("services").queryOrderedByKey()
        newRef?.observe(.value, with: { snapshot in
            print(snapshot.value)
            if let snapshots = snapshot.children.allObjects as? [FIRDataSnapshot] {
                for snap in snapshots {
                    if let dict = snap.value as? Dictionary<String, AnyObject> {
                        let service = Service()
                        service.setValuesForKeys(dict)
                        self.services.append(service)
                    }
                }
            }
        })
        tableView.reloadData()
    }
    

    
}

// MARK: Table View Data Source

extension SidePanelViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return services.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableView.CellIdentifiers.ServiceTypeCell, for: indexPath) as! ServiceTypeCell
        cell.configureForAnimal(services[(indexPath as NSIndexPath).row])
        return cell
    }
    
}

// Mark: Table View Delegate

extension SidePanelViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
}

class ServiceTypeCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    func configureForAnimal(_ service: Service) {
        titleLabel.text = service.title
    }
    
}

