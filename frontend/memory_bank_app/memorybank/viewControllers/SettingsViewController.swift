//
//  SettingsViewController.swift
//  memorybank
//
//  Created by David Sun on 11/24/19.
//  Copyright © 2019 Dubal, Rohan. All rights reserved.
//

import UIKit
import Eureka

class SettingsViewController: FormViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureForm()
    }

    func configureForm() {
        form +++ Section()
            <<< ButtonRow(){
                $0.title = "Log Out"
                $0.cell.tintColor = .red
            }
    }
    
    @IBAction func clickDismiss(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
