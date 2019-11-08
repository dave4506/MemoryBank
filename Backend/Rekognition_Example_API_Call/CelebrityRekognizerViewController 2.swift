//
// Copyright 2014-2018 Amazon.com,
// Inc. or its affiliates. All Rights Reserved.
//
// Licensed under the Amazon Software License (the "License").
// You may not use this file except in compliance with the
// License. A copy of the License is located at
//
//     http://aws.amazon.com/asl/
//
// or in the "license" file accompanying this file. This file is
// distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, express or implied. See the License
// for the specific language governing permissions and
// limitations under the License.
//

import Foundation
import AWSCognitoIdentityProvider
import AWSRekognition

class CelebrityRekognizerViewController : UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
   
    var rekognitionObject:AWSRekognition?
    
    // Mark: Properties
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setToolbarHidden(true, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setToolbarHidden(false, animated: true)
    }
    
    // MARK: - IBActions
    @IBAction func signOut(_ sender: Any) {
        let pool = AWSCognitoIdentityUserPool(forKey: CognitoUserPoolsSignInProviderKey)
        pool.currentUser()?.signOut()
        pool.clearLastKnownUser()
        let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
        appDelegate?.refreshCredentials()
    }
    
    @IBAction func useCamera(_ sender: Any) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .camera
        pickerController.cameraCaptureMode = .photo
        present(pickerController, animated: true)
    }
    
    @IBAction func useImageLibrary(_ sender: Any) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .savedPhotosAlbum
        present(pickerController, animated: true)
    }
    
    // MARK: - UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        imageView.image = selectedImage
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
        
        let imageData:Data = selectedImage.jpegData(compressionQuality: 0.95)!
        sendImageToRekognition(celebImageData: imageData)
    }
    
    //MARK: - AWS Methods
    func sendImageToRekognition(celebImageData: Data){
        
        //Delete older labels or buttons
        DispatchQueue.main.async {
            [weak self] in
            for subView in (self?.imageView.subviews)! {
                subView.removeFromSuperview()
            }
        }
        
        rekognitionObject = AWSRekognition.default()
        let celebImageAWS = AWSRekognitionImage()
        celebImageAWS?.bytes = celebImageData
        let celebRequest = AWSRekognitionRecognizeCelebritiesRequest()
        celebRequest?.image = celebImageAWS
        
        rekognitionObject?.recognizeCelebrities(celebRequest!){
            (result, error) in
            if error != nil{
                let msg = "Celebrity rekognizer failed: " + (error as? String ?? "unknown error")
                let alert = UIAlertController(title: "Celebrity rekognizer", message: msg, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                self.present(alert, animated: true)
                return
            }
            
            //1. First we check if there are any celebrities in the response
            if ((result!.celebrityFaces?.count)! > 0){
                
                //2. Celebrities were found. Lets iterate through all of them
                for (index, celebFace) in result!.celebrityFaces!.enumerated(){
                    
                    //Check the confidence value returned by the API for each celebirty identified
                    if(celebFace.matchConfidence!.intValue > 10){ //Adjust the confidence value to whatever you are comfortable with
                        
                        //We are confident this is celebrity. Lets point them out in the image using the main thread
                        DispatchQueue.main.async {
                            [weak self] in
                            
                            //Create an instance of Celebrity. This class is availabe with the starter application you downloaded
                            let celebrityInImage = Celebrity()
                            
                            celebrityInImage.scene = (self?.imageView)!
                            
                            //Get the coordinates for where this celebrity face is in the image and pass them to the Celebrity instance
                            celebrityInImage.boundingBox = ["height":celebFace.face?.boundingBox?.height, "left":celebFace.face?.boundingBox?.left, "top":celebFace.face?.boundingBox?.top, "width":celebFace.face?.boundingBox?.width] as? [String : CGFloat]
                            
                            //Get the celebrity name and pass it along
                            celebrityInImage.name = celebFace.name!
                            let infoButton:UIButton = celebrityInImage.createInfoButton()
                            infoButton.tag = index
                            self?.imageView.addSubview(infoButton)
                        }
                    }
                }
            } else if ((result!.unrecognizedFaces?.count)! > 0)  {
                //3. No Celebrities were found.
                let msg = "No celebrities found in image"
                let alert = UIAlertController(title: "Celebrity rekognizer", message: msg, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                self.present(alert, animated: true)
                
                for (index, face) in result!.unrecognizedFaces!.enumerated() {
                        DispatchQueue.main.async {
                            [weak self] in
                            let facesInImage = Celebrity()
                                
                            facesInImage.scene = (self?.imageView)!
                            facesInImage.boundingBox = ["height":face.boundingBox?.height, "left":face.boundingBox?.left, "top":face.boundingBox?.top, "width":face.boundingBox?.width] as? [String : CGFloat]
                                
                            facesInImage.name = "unknown"
                            let infoButton:UIButton = facesInImage.createInfoButton()
                            infoButton.tag = index
                            self?.imageView.addSubview(infoButton)
                        }
                    }
                
            } else {
                //4. No faces were found (presumably no people were found either)
                let msg = "No faces found in image"
                let alert = UIAlertController(title: "Celebrity rekognizer", message: msg, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                self.present(alert, animated: true)
            }
        }
        
    }
    
    

}
