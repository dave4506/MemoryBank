//
//  CreateEventViewController.swift
//  memorybank
//
//  Created by David Sun on 11/25/19.
//  Copyright © 2019 Dubal, Rohan. All rights reserved.
//

import UIKit
import Eureka

class CreateEventViewController: FormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureForm()
        // Do any additional setup after loading the view.
    }

    func configureForm() {
        form +++ Section("Section1")
            <<< TextRow(){ row in
                row.title = "Text Row"
                row.placeholder = "Enter text here"
            }
            <<< PhoneRow(){
                $0.title = "Phone Row"
                $0.placeholder = "And numbers here"
            }
        +++ Section("Section2")
            <<< DateRow(){
                $0.title = "Date Row"
                $0.value = Date(timeIntervalSinceReferenceDate: 0)
            }
    }
    
    @IBAction func dismissViewController(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
 
