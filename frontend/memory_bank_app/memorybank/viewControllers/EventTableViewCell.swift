//
//  EventTableViewCell.swift
//  memorybank
//
//  Created by Stewart Vohra on 11/23/19.
//  Copyright © 2019 Dubal, Rohan. All rights reserved.
//

import UIKit
import os.log

class EventTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: Properties:
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var idLabel: UILabel!
    
    @IBOutlet weak var locLabel: UILabel!
    
    @IBOutlet weak var infoLabel: UILabel!
    
    @IBOutlet weak var startLabel: UILabel!
    
    @IBOutlet weak var endLabel: UILabel!
}
