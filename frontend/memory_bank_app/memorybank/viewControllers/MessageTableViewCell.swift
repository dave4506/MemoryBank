//
//  MessageTableViewCell.swift
//  memorybank
//
//  Created by Stewart Vohra on 11/25/19.
//  Copyright © 2019 Dubal, Rohan. All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: Properties
    @IBOutlet weak var messageLabel: UILabel!
    
    
}
