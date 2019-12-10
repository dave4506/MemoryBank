//
//  SettingsViewController.swift
//  memorybank
//
//  Created by David Sun on 11/24/19.
//  Copyright © 2019 Dubal, Rohan. All rights reserved.
//

import UIKit
import Eureka

@available(iOS 10.0, *)
class SettingsViewController: FormViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureForm()
    }

    func configureForm() {
        form +++ Section("User Details")
            <<< LabelRow(){
                $0.title = "Email"
                $0.value = getUserSession()?.email ?? ""
            }
            <<< ButtonRow(){
                $0.title = "Change Passcode"
                $0.cell.tintColor = .gray
            }
            +++ Section("Notification Settings")
            <<< SwitchRow() {
                $0.title = "Enable Notification"
                $0.value = true
            }
            +++ Section()
            <<< ButtonRow(){
                $0.title = "Log Out"
                $0.cell.tintColor = .red
            }.onCellSelection { cell, row in
                self.navigationController?.popToRootViewController(animated: true)
            }
    }

}
