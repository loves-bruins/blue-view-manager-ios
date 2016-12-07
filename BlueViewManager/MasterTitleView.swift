//
//  MasterTitleView.swift
//  BlueViewManager
//
//  Created by Loren Rogers on 12/5/16.
//  Copyright © 2016 Loren Rogers. All rights reserved.
//

import UIKit

class MasterTitleView: UIView {

    @IBOutlet weak var applicationTitle: UILabel!
    @IBOutlet weak var loggedInUser: UILabel!
  
    var view: UIView!
    
    func instanceFromNib() -> UIView {
        return UINib(nibName: "MasterTitleView", bundle: nil).instantiate(withOwner: self, options: nil).first as! UIView
    }
    /*
     * Programmatic version
     */
    override init(frame:CGRect)
    {
        super.init(frame: frame)
        
        xibSetup()
    }
    
    /*
     * Storyboard version
     */
    required init?(coder aDecoder : NSCoder)
    {
        super.init(coder: aDecoder)
        //xibSetup()

    }
    
    func xibSetup() {
        view = instanceFromNib()
        view.frame = bounds;
        view.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        (view as! MasterTitleView).applicationTitle?.text = "Blue View Aquatics"
        (view as! MasterTitleView).loggedInUser?.text = "Not Logged In"
        addSubview(view)
    }
    
    
//    convenience init()
//    {
//        self.init()
//    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
