//
//  WaterChangeServiceViewController.swift
//  BlueViewManager
//
//  Created by Loren Rogers on 12/21/16.
//  Copyright © 2016 Loren Rogers. All rights reserved.
//

import UIKit

class WaterChangeServiceViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.tabBarController?.navigationItem.title = "Water Change"
        let logButton = UIBarButtonItem(title: "Add", style: .plain, target: self, action: Selector(""))
        
        self.tabBarController?.navigationItem.rightBarButtonItem = logButton
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
