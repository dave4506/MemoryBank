//
//  AddFamilyLabelViewController.swift
//  memorybank
//
//  Created by David Sun on 11/26/19.
//  Copyright © 2019 Dubal, Rohan. All rights reserved.
//

import UIKit
import Eureka
import Firebase

class AddFamilyLabelViewController: FormViewController {

    var identification: Identification?
    
    var label: String?
    var descript: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.configureForm()
    }
    
    @IBAction func dismissCLicked(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    func updateForm() {
        (self.form.rowBy(tag: "guess") as? LabelRow)?.value = self.identification?.guess ?? ""
        (self.form.rowBy(tag: "guess") as? LabelRow)?.reload()
    }
    
    func configureForm() {
        form +++ Section("Help out!")
            <<< LabelRow("guess") {
                $0.title = "Our guess"
                $0.value = self.identification?.guess ?? ""
            }
            <<< TextRow("eventName") {
                // $0.hidden = "$segments != 'Family Member'"
                $0.title = "What is it?"
                $0.placeholder = "Heirloom"
            }.cellUpdate { cell, row in
                self.label = cell.textField.text
            }
            <<< TextAreaRow("description"){
                // $0.hidden = "$segments != 'Family Member'"
                $0.title = "Description"
                $0.placeholder = "Describe in detail"
            }.cellUpdate { cell, row in
                self.descript = cell.textView.text
            }
            <<< ButtonRow(){
                $0.title = "Submit Identification"
            }.onCellSelection { cell, row in
                self.submitIdentification()
            }
    }
    
    func submitIdentification() {
        guard let identification = self.identification else { return }
        let db = Firestore.firestore()
        let identificationObject = db.collection("identifcations").document(identification.id);
        print(identificationObject.path)
        identificationObject.updateData([
            "family_label": self.label,
            "family_description": self.descript
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
                self.dismiss(animated: true)
            }
        }

    }
}
