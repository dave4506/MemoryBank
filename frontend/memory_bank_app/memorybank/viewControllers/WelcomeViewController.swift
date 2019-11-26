//
//  WelcomeViewController.swift
//  memorybank
//
//  Created by David Sun on 11/25/19.
//  Copyright © 2019 Dubal, Rohan. All rights reserved.
//

import UIKit
import Eureka

class WelcomeViewController: FormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureForm()
    }
    
    func configureForm() {
        form +++ Section() { section in
                var header = HeaderFooterView<UIView>(.nibFile(name: "OnboardSectionHeader", bundle: Bundle.main))

                // Will be called every time the header appears on screen
                header.onSetupView = { view, _ in
                    // Commonly used to setup texts inside the view
                    // Don't change the view hierarchy or size here!
                }
                section.header = header
            }
            <<< ButtonRow(){
                $0.title = "Returning User"
            }.onCellSelection {  cell, row in
                self.performSegue(withIdentifier: "showSignIn", sender: self)
            }
            <<< ButtonRow(){
                $0.title = "New User"
            }.onCellSelection {  cell, row in
                self.performSegue(withIdentifier: "showSignUp", sender: self)
            }
    }
}
