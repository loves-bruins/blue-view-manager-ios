//
//  SidePanelViewController.swift
//  BlueViewManager
//
//  Created by Loren Rogers on 12/15/16.
//  Copyright © 2016 Loren Rogers. All rights reserved.
//

import UIKit

@objc
protocol SidePanelViewControllerDelegate {
    func typeSelected(_ service: Service)
}

class SidePanelViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var animals: Array<Animal>!
    
    struct TableView {
        struct CellIdentifiers {
            static let ServiceTypeCell = "ServiceTypeCell"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.reloadData()
    }
    
}

// MARK: Table View Data Source

extension SidePanelViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableView.CellIdentifiers.ServiceTypeCell, for: indexPath) as! ServiceTypeCell
        cell.configureForAnimal(animals[(indexPath as NSIndexPath).row])
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

