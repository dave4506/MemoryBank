//
//  CreateIdentificationRequestViewController.swift
//  memorybank
//
//  Created by David Sun on 11/26/19.
//  Copyright © 2019 Dubal, Rohan. All rights reserved.
//

import UIKit
import Eureka
import ImageRow
import Firebase
import FirebaseStorage
import AVFoundation

class CreateIdentificationRequestViewController: FormViewController {

    var selectedImage: UIImage?
    var bestGuess: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureForm()
    }

    func configureForm() {
        form +++ Section("What do you need help with?")
            <<< ImageRow(){ row in
                row.title = "Select or taker a photo"
                row.sourceTypes = [.PhotoLibrary, .SavedPhotosAlbum, .Camera]
                row.clearAction = .yes(style: UIAlertAction.Style.destructive)
            }.onChange {
                self.selectedImage = $0.value
                self.findBestGuess()
            }
            <<< LabelRow("guess"){
                $0.title = "Our guess"
                $0.value = self.bestGuess ?? ""
            }
            <<< ButtonRow(){
                $0.title = "Ask family for identifcation"
            }.onCellSelection { cell, row in
                self.submitIdentificationRequestion()
            }
    }
    
    @IBAction func dismissClicked(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    func submitIdentificationRequestion() {
        guard let selectedImage = self.selectedImage else { return }
        let db = Firestore.firestore()
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let identificationObject = db.collection("identifcations").document();
        
        print(identificationObject.path)
        
        let imagesRef = storageRef.child("images").child(identificationObject.documentID + ".jpg")

        print(imagesRef.fullPath)

        let _ = imagesRef.putData(selectedImage.jpegData(compressionQuality: 0.2)!, metadata: nil) { (metadata, error) in
          guard let _ = metadata else {
            // Uh-oh, an error occurred!
            return
          }
          // Metadata contains file metadata such as size, content-type.
          // You can also access to download URL after upload.
          imagesRef.downloadURL { (url, error) in
            guard let downloadURL = url else {
              // Uh-oh, an error occurred!
              return
            }
            identificationObject.setData([
                "guess": self.bestGuess ?? "",
                "image_url": downloadURL.absoluteString
            ]) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")
                    self.dismiss(animated: true)
                }
            }
          }
        }
    }
    
    func findBestGuess() {
        guard let selectedImage = self.selectedImage else { return }
        print("attempting to label...")
        let image = VisionImage(image: selectedImage)
        let labeler = Vision.vision().onDeviceImageLabeler()
        labeler.process(image) { labels, error in
            guard error == nil, let labels = labels else { return }
            if let bestGuess = labels.first {
                self.bestGuess = bestGuess.text
                print("bestGuess", bestGuess.text)
                (self.form.rowBy(tag: "guess") as? LabelRow)?.value = bestGuess.text
                (self.form.rowBy(tag: "guess") as? LabelRow)?.reload()
            }
        }
    }
}
