//
//  BlueToothTableViewCell.swift
//  BlueSniff
//
//  Created by Nick Walter on 8/6/15.
//  Copyright © 2015 Nick Walter. All rights reserved.
//

import UIKit

class BlueToothTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var rssiLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
