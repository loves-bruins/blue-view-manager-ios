//
//  ServicesPerUserViewController.swift
//  BlueViewManager
//
//  Created by Loren Rogers on 12/14/16.
//  Copyright © 2016 Loren Rogers. All rights reserved.
//

import UIKit

@objc
protocol ServicesPerUserViewControllerDelegate {
    @objc optional func toggleRightPanel()
    @objc optional func collapseSidePanels()
}

class ServicesPerUserViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var delegate: ServicesPerUserViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addService))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addService(_ sender: AnyObject) {
        delegate?.toggleRightPanel?()
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
