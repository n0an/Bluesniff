//
//  BlueTableViewCell.swift
//  BlueTracker
//
//  Created by nag on 25/08/2017.
//  Copyright © 2017 Anton Novoselov. All rights reserved.
//

import UIKit

class BlueTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var peripheralNameLabel: UILabel!
    
    @IBOutlet weak var rssiLabel: UILabel!
    
    @IBOutlet weak var uuidLabel: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
