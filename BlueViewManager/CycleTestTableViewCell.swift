//
//  CycleTestTableViewCell.swift
//  BlueViewManager
//
//  Created by Loren Rogers on 12/7/16.
//  Copyright © 2016 Loren Rogers. All rights reserved.
//

import UIKit

class CycleTestTableViewCell: UITableViewCell {
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var nitrateLevel: UILabel!
    @IBOutlet weak var ammoniaLevel: UILabel!
    @IBOutlet weak var nitriteLevel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
