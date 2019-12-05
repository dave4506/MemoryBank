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
        if let isPatient = getUserSession()?.isPatient {
            if !isPatient {
                self.configureFamilyForm()
            } else {
                self.configurePatientForm()
                self.navigationController?.navigationBar.topItem?.title = "From your family"
            }
            self.getIdentification()
        }
    }
    
    @IBAction func dismissCLicked(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    func updateForm() {
        (self.form.rowBy(tag: "guess") as? LabelRow)?.value = self.identification?.guess ?? ""
        (self.form.rowBy(tag: "guess") as? LabelRow)?.reload()
    }
    
    func configureFamilyForm() {
        form +++ Section("Help out!")
            <<< LabelRow("guess") {
                $0.title = "Our guess"
                $0.value = self.identification?.guess ?? ""
            }
            <<< TextRow("familyLabel") {
                $0.title = "What is it?"
                $0.placeholder = "Heirloom"
            }.cellUpdate { cell, row in
                self.label = cell.textField.text
            }
            <<< TextAreaRow("description"){
                $0.title = "Family Description"
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
    
    func configurePatientForm() {
        form +++ Section("What is the item?")
            <<< LabelRow("guess") {
                $0.title = "Our guess"
                $0.value = self.identification?.guess ?? ""
            }
            <<< TextRow("familyLabel") {
                $0.title = "Family Label"
                $0.value = ""
                $0.baseCell.isUserInteractionEnabled = false
            }
            <<< TextAreaRow("description"){
                $0.title = "Family Description"
                $0.value = ""
                $0.baseCell.isUserInteractionEnabled = false
            }
    }
    
    func getIdentification() {
        guard let identification = self.identification else { return }
        let db = Firestore.firestore()
        let identificationObject = db.collection("identifcations").document(identification.id);
        identificationObject.getDocument {
            if let document = $0, document.exists {
                if let id = document.data() {
                    self.label = id["family_label"] as? String
                    self.descript = id["family_description"] as? String
                    if let label = self.label, let descript = self.descript {
                        (self.form.rowBy(tag: "familyLabel") as? TextRow)?.value = label
                        (self.form.rowBy(tag: "familyLabel") as? TextRow)?.reload()
                        (self.form.rowBy(tag: "description") as? TextAreaRow)?.value = descript
                        (self.form.rowBy(tag: "description") as? TextAreaRow)?.reload()
                    }
                }
            } else {
                print("Document does not exist", $1)
            }
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
