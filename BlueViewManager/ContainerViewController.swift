//
//  ContainerViewController.swift
//  BlueViewManager
//
//  Created by Loren Rogers on 12/15/16.
//  Copyright © 2016 Loren Rogers. All rights reserved.
//

import UIKit
import QuartzCore

enum SlideOutState {
    case RightPanelCollapsed
    case RightPanelExpanded
}

class ContainerViewController: UIViewController {
    
    // var centerNavigationController: UINavigationController!
    var centerViewController: ServicesPerUserViewController!
    var currentState: SlideOutState = .RightPanelCollapsed
    var rightViewController: SidePanelViewController?
    let centerPanelExpandedOffset: CGFloat = 60
    
    override func viewDidLoad() {
        super.viewDidLoad()

        centerViewController = UIStoryboard.centerViewController()
        centerViewController.delegate = self
        
        // wrap the centerViewController in a navigation controller, so we can push views to it
        // and display bar button items in the navigation bar
        //centerNavigationController = UINavigationController(rootViewController: centerViewController)
        //view.addSubview((self.navigationController?.view)!) //centerNavigationController.view)
        //addChildViewController(centerNavigationController)
        
        //centerNavigationController.didMove(toParentViewController: self)
        //self.navigationController?.didMove(toParentViewController: self)
    }
    
    @IBAction func showServices(_ sender: AnyObject) {
        centerViewController.addService(sender)
    }
}

// MARK: CenterViewController delegate

extension ContainerViewController: ServicesPerUserViewControllerDelegate {
    
    func toggleRightPanel() {
        let notAlreadyExpanded = (currentState != .RightPanelExpanded)
        
        if notAlreadyExpanded {
            addRightPanelViewController()
        }
        
        animateRightPanel(shouldExpand: notAlreadyExpanded)
        rightViewController?.view.bringSubview(toFront: (rightViewController?.tableView)!)
    }
    
    func addRightPanelViewController() {
        if (rightViewController == nil) {
            rightViewController = UIStoryboard.rightViewController()
            
            addChildSidePanelController(rightViewController!)
        }
    }
    
    func addChildSidePanelController(_ sidePanelController: SidePanelViewController) {
        view.insertSubview(sidePanelController.view, at: 0)
        
        addChildViewController(sidePanelController)
        sidePanelController.didMove(toParentViewController: self)
    }
    
    func animateRightPanel(shouldExpand: Bool) {
        if (shouldExpand) {
            currentState = .RightPanelExpanded
            var frameWidth = CGFloat(0)
            frameWidth = (self.navigationController?.view.frame.width)!
            animateCenterPanelXPosition(targetPosition: -frameWidth + centerPanelExpandedOffset)
        } else {
            animateCenterPanelXPosition(targetPosition: 0) { finished in
                self.currentState = .RightPanelCollapsed
                
                self.rightViewController!.view.removeFromSuperview()
                self.rightViewController = nil;
            }
        }
    }
    
    func animateCenterPanelXPosition(targetPosition: CGFloat, completion: ((Bool) -> Void)! = nil) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.navigationController?.view.frame.origin.x = targetPosition
            }, completion: completion)
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
