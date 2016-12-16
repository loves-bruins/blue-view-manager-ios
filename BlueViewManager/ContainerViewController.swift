//
//  ContainerViewController.swift
//  BlueViewManager
//
//  Created by Loren Rogers on 12/15/16.
//  Copyright © 2016 Loren Rogers. All rights reserved.
//

import UIKit
import QuartzCore

class ContainerViewController: UIViewController {
    
    var centerNavigationController: UINavigationController!
    var centerViewController: ServicesPerUserViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        centerViewController = UIStoryboard.centerViewController()
        centerViewController.delegate = self
        
        // wrap the centerViewController in a navigation controller, so we can push views to it
        // and display bar button items in the navigation bar
        centerNavigationController = UINavigationController(rootViewController: centerViewController)
        view.addSubview(centerNavigationController.view)
        addChildViewController(centerNavigationController)
        
        centerNavigationController.didMove(toParentViewController: self)
    }
    
}

// MARK: CenterViewController delegate

extension ContainerViewController: ServicesPerUserViewControllerDelegate {
    
    func toggleRightPanel() {
    }
    
    func addRightPanelViewController() {
    }
    
    func animateRightPanel(shouldExpand: Bool) {
    }
    
}

private extension UIStoryboard {
    class func mainStoryboard() -> UIStoryboard { return UIStoryboard(name: "AdminFunctions", bundle: Bundle.main) }
        
    class func rightViewController() -> SidePanelViewController? {
        return mainStoryboard().instantiateViewController(withIdentifier: "RightViewController") as? SidePanelViewController
    }
    
    class func centerViewController() -> ServicesPerUserViewController? {
        return mainStoryboard().instantiateViewController(withIdentifier: "ServicesViewController") as? ServicesPerUserViewController
    }
    
}
