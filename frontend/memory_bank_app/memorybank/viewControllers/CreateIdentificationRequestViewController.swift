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
import Alamofire
import SwiftyJSON

@available(iOS 10.0, *)
class CreateIdentificationRequestViewController: FormViewController {

    var selectedImage: UIImage?
    var bestGuess: String?
    var uploadURL: String?
    typealias FinishedDownload = () -> ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureForm()
    }

    func configureForm() {
        form +++ Section("What do you need help with?")
            <<< ImageRow(){ row in
                row.title = "Select or take a photo"
                row.sourceTypes = [.PhotoLibrary, .SavedPhotosAlbum, .Camera]
                row.clearAction = .yes(style: UIAlertAction.Style.destructive)
            }.onChange {
                self.selectedImage = $0.value
                self.getPresignedLink()
                //self.searchRekognition()
            }
            <<< LabelRow("guess"){
                $0.title = "Our guess"
                $0.value = self.bestGuess ?? ""
            }
//            <<< ButtonRow(){
//                $0.title = "Ask family for identifcation"
//            }.onCellSelection { cell, row in
//                self.submitIdentificationRequestion()
//            }
    }
    
    @IBAction func dismissClicked(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    func getPresignedLink() {
        guard let selectedImage = self.selectedImage else { return }
        
        let headers: HTTPHeaders = [
            "Authorization": getUserSession()?.token ?? "NULL",
            "Accept": "application/json"
        ]
        
        Alamofire.request("https://memorybank-staging.herokuapp.com/upload/search", method: .get, headers: headers).validate().responseJSON { response in
            if let result = response.result.value {
                print(response)
                let JSON = result as! NSDictionary
                print("json successfully created")
                print("JSON: \(JSON)")
                let parameters: [String: AnyObject] = JSON.object(forKey: "fields") as! [String : AnyObject]
                let S3 = S3UploadCredentials(key: parameters["Key"] as! String, policy: parameters["Policy"] as! String, algorithm: parameters["X-Amz-Algorithm"] as! String, credential: parameters["X-Amz-Credential"] as! String, date: parameters["X-Amz-Date"] as! String, signature: parameters["X-Amz-Signature"] as! String, bucket: parameters["bucket"] as! String)
                
                let ciImage = CIImage(cgImage: selectedImage.cgImage!)

                let options = [CIDetectorAccuracy: CIDetectorAccuracyHigh]
                let faceDetector = CIDetector(ofType: CIDetectorTypeFace, context: nil, options: options)!

                let faces = faceDetector.features(in: ciImage)

                if let face = faces.first as? CIFaceFeature {
                    DispatchQueue.main.async(execute: {
                        self.uploadtoS3(image: selectedImage, bucketURL: JSON.object(forKey: "url") as! String, uploadCredentials: S3, completed: { () -> () in
                            self.searchRekognition()
                        })
                        
                    })
                } else {
                    self.uploadtoS3(image: selectedImage, bucketURL: JSON.object(forKey: "url") as! String, uploadCredentials: S3, completed: { () -> () in
                        self.findBestGuess()
                    })
                }
                
                
            }
        }
        
    }
    
    func uploadtoS3(image: UIImage, bucketURL: String, uploadCredentials s3: S3UploadCredentials, completed: @escaping FinishedDownload){
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
            // Provide a meaningful error for your app here
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
                upload.responseData { response in
                    switch response.result {
                    case .success:
                        print(response.response!.statusCode)

                        if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                            print("Server Response: \(utf8Text)") // original server data as UTF8 string
                            completed()
                        }
                        
                        break
                    case .failure(let error):
                        print(response.response!.statusCode)
                        debugPrint(error)

                        break
                    }
                }
            case .failure(let encodingError):
                print(encodingError)
            }
        }
        
    }

    
    func searchRekognition(){
        
        let headers: HTTPHeaders = [
            "Authorization": getUserSession()?.token ?? "NULL",
            "Accept": "application/json"
        ]
        
        Alamofire.request("https://memorybank-staging.herokuapp.com/search", method: .get, headers: headers).validate().responseJSON { response in
            
            if(response.error != nil){
                if(response.response!.statusCode == 500){
                    print("Face not found")
                    self.bestGuess = "Waiting for Family"
                    (self.form.rowBy(tag: "guess") as? LabelRow)?.value = self.bestGuess
                    (self.form.rowBy(tag: "guess") as? LabelRow)?.reload()
                    showLocalNotification()
                    self.submitIDRequest()
                }
            }
            if let result = response.result.value {
                let JSON = result as! NSDictionary
                print("json successfully created")

                let bestGuess = JSON.object(forKey: "result") as! String
                self.bestGuess = bestGuess
                print("bestGuess", bestGuess)
                (self.form.rowBy(tag: "guess") as? LabelRow)?.value = bestGuess
                (self.form.rowBy(tag: "guess") as? LabelRow)?.reload()
                self.submitIDRequest()
                
            }
        }
    }
    
    func submitIDRequest() {
        guard let selectedImage = self.selectedImage else { return }
        
        let db = Firestore.firestore()
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let identificationObject = db.collection("identifcations").document();
        
        
        print(identificationObject.path)
        
        let imagesRef = storageRef.child("images").child(identificationObject.documentID + ".jpg")

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
                "image_url": downloadURL.absoluteString,
                "created": FieldValue.serverTimestamp()
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
        let options = VisionCloudImageLabelerOptions()
        options.confidenceThreshold = 0.7
        let image = VisionImage(image: selectedImage)
        let labeler = Vision.vision().cloudImageLabeler(options: options)
        labeler.process(image) { labels, error in
            guard error == nil, let labels = labels else { return }
            if let bestGuess = labels.first {
                self.bestGuess = bestGuess.text
                print("bestGuess", bestGuess.text)
                (self.form.rowBy(tag: "guess") as? LabelRow)?.value = bestGuess.text
                (self.form.rowBy(tag: "guess") as? LabelRow)?.reload()
                self.submitIDRequest()
            }
        }
    }
}
