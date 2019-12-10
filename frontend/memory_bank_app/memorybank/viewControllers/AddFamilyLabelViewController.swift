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
import Alamofire
import SwiftyJSON

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
        self.getPresignedURL()
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
    
    func getPresignedURL(){
        
        let parameters = [
            "faceName": self.label!
        ] as Parameters
        
        let headers = [
            "Authorization": getUserSession()?.token ?? ""
        ] as HTTPHeaders
        
        Alamofire.request("https://memorybank-staging.herokuapp.com/upload/face", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
                print(response)
                if let result = response.result.value {
                    let JSON = result as! NSDictionary
                    print("json successfully created")
                    print("JSON: \(JSON)")
                    let parameters: [String: AnyObject] = JSON.object(forKey: "fields") as! [String : AnyObject]
                    let S3 = S3UploadCredentials(key: parameters["Key"] as! String, policy: parameters["Policy"] as! String, algorithm: parameters["X-Amz-Algorithm"] as! String, credential: parameters["X-Amz-Credential"] as! String, date: parameters["X-Amz-Date"] as! String, signature: parameters["X-Amz-Signature"] as! String, bucket: parameters["bucket"] as! String)
                    
                    DispatchQueue.main.async(execute: {
                        self.uploadtoS3(image: self.identification!.image, bucketURL: JSON.object(forKey: "url") as! String, uploadCredentials: S3, completion: { (success) -> Void in
                            if success {
                                self.uploadtoRekognition()
                            }
                        })
                        
                    })
                    
                }
        }
    }
    
    func uploadtoS3(image: UIImage, bucketURL: String, uploadCredentials s3: S3UploadCredentials, completion: @escaping ((Bool) -> ())){
        let parameter = ["Policy": s3.policy,
                         "X-Amz-Algorithm": s3.algorithm,
                         "X-Amz-Credential": s3.credential,
                         "X-Amz-Date": s3.date,
                         "X-Amz-Signature": s3.signature,
                         "Key": s3.key,
                         "bucket": s3.bucket]
        
        print(parameter)

        guard let data = image.jpegData(compressionQuality: 1.0) else {
          let err = NSError(domain: "pl.appbeat", code: 9_999, userInfo: ["Data error": "Was not able to prepare image from data."])
          completion(false) // Provide a meaningful error for your app here
          return
        }

        Alamofire.upload(multipartFormData: { (multipartForm) in

            for (key, value) in parameter {

                multipartForm.append(value.data(using: .utf8)!, withName: key)

            }

            multipartForm.append(data, withName: "file")//, fileName: "file", mimeType: "image/jpeg")
        }, to: bucketURL, method : .post, headers: nil) { (encodingResult) in

            switch encodingResult {
            case .success(let upload, _, _):
                completion(true)
                upload.responseData { response in
                    switch response.result {
                    case .success:
                        completion(true)
                        print(response.response!.statusCode)

                        if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                            print("Server Response: \(utf8Text)") // original server data as UTF8 string
                        }
                        
                        break
                    case .failure(let error):
                        print(response.response!.statusCode)
                        debugPrint(error)

                        break
                    }
                }
            case .failure(let encodingError):
                completion(false)
                print(encodingError)
            }
        }
        
    }


    func uploadtoRekognition(){

        let headers: HTTPHeaders = [
            "Authorization": getUserSession()?.token ?? "NULL",
            "Accept": "application/json"
        ]
        
        let parameters = [
            "faceName": self.label!
        ] as Parameters

        Alamofire.request("https://memorybank-staging.herokuapp.com/rekognize", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON{ response in
            print(response)
            if let result = response.result.value {
                if((response.error) == nil){
                    print(result)
                }
            }
        }
    }
}
