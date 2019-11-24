//
//  EventTableViewCell.swift
//  memorybank
//
//  Created by Stewart Vohra on 11/23/19.
//  Copyright © 2019 Dubal, Rohan. All rights reserved.
//

import UIKit

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
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var infoTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var startTextField: UITextField!
    @IBOutlet weak var endTextField: UITextField!
    @IBOutlet weak var idTextField: UITextField!
}
