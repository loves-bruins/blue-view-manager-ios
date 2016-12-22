//
//  AlgaeScrapeViewController.swift
//  BlueViewManager
//
//  Created by Loren Rogers on 12/22/16.
//  Copyright © 2016 Loren Rogers. All rights reserved.
//

import UIKit

class AlgaeScrapeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tabBarController?.navigationItem.title = "Algae Scrape"
        let addButton = UIBarButtonItem(title: "Add", style: .plain, target: self, action: Selector(""))
        
        self.tabBarController?.navigationItem.rightBarButtonItem = addButton
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
