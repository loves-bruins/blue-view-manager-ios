//
//  DetailViewController.swift
//  BlueViewManager
//
//  Created by Loren Rogers on 12/2/16.
//  Copyright © 2016 Loren Rogers. All rights reserved.
//

import UIKit

enum Views {
    case cycleTests, services
}

class DetailViewController: UIViewController {
    
    var userId: String!

    private lazy var cycleTestsViewController: CycleTestsPerUserViewController = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "AdminFunctions", bundle: Bundle.main)
        
        // Instantiate View Controller
        var viewController = storyboard.instantiateViewController(withIdentifier: "CycleTests") as! CycleTestsPerUserViewController
        viewController.userId = self.userId
        // Add View Controller as Child View Controller
        self.add(asChildViewController: viewController)
        
        return viewController
    }()
    
    private lazy var servicesViewController: ServicesPerUserViewController = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "AdminFunctions", bundle: Bundle.main)
        
        // Instantiate View Controller
        var viewController = storyboard.instantiateViewController(withIdentifier: "ServicesPerUserViewController") as! ServicesPerUserViewController
        
        viewController.userId = self.userId
        // Add View Controller as Child View Controller
        self.add(asChildViewController: viewController)
        
        return viewController
    }()

    private func add(asChildViewController viewController: UIViewController) {
        // Add Child View Controller
        addChildViewController(viewController)
        
        // Add Child View as Subview
        view.addSubview(viewController.view)
        
        // Configure Child View
        viewController.view.frame = view.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Notify Child View Controller
        viewController.didMove(toParentViewController: self)
    }

    private func remove(asChildViewController viewController: UIViewController) {
        // Notify Child View Controller
        viewController.willMove(toParentViewController: nil)
        
        // Remove Child View From Superview
        viewController.view.removeFromSuperview()
        
        // Notify Child View Controller
        viewController.removeFromParentViewController()
    }
    
    func configureView() {
        // Update the user interface for the detail item.
        if let view = self.View {
            if view == .cycleTests {
                self.navigationItem.title = "Cycle Tests"
                remove(asChildViewController: servicesViewController)
                add(asChildViewController: cycleTestsViewController)
            }
            else if view == .services {
                self.navigationItem.title = "Services"
                remove(asChildViewController: cycleTestsViewController)
                add(asChildViewController: servicesViewController)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var View: Views? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }


}

