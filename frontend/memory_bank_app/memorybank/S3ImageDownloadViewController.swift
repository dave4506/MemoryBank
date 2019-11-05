//
//  S3ImageDownloadViewController.swift
//  memorybank
//
//  Created by Stewart Vohra on 11/3/19.
//  Copyright © 2019 Dubal, Rohan. All rights reserved.
//

import Foundation
import AWSCognitoIdentityProvider
import AWSS3

class S3ImageDownloadViewController : UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    //Mark: Properties
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var downloadImageButton: UIButton!
    
    @IBOutlet weak var keyTextField: UITextField!
    
    var imageKey: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Handle the text field’s user input through delegate callbacks.
        keyTextField.delegate = self
        
        // Enable the Save button only if the text field has a valid Meal name.
        updateSaveButtonState()
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
    @IBAction func signOut(_ sender: UIButton) {
        let pool = AWSCognitoIdentityUserPool(forKey: CognitoUserPoolsSignInProviderKey)
        pool.currentUser()?.signOut()
        pool.clearLastKnownUser()
//        let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
//        appDelegate?.refreshCredentials()
    }
    
    @IBAction func downloadImage(_ sender: UIButton) {
        let pool = AWSCognitoIdentityUserPool(forKey: CognitoUserPoolsSignInProviderKey)
        var username: String = (pool.currentUser()?.username)!
        username = username.replacingOccurrences(of: ".", with: "-")
        
        let getObjectRequest = AWSS3GetObjectRequest()
        getObjectRequest?.bucket = s3Bucket
        let key = username + "/images/" + keyTextField.text! + ".jpeg"
        getObjectRequest?.key = key
        
        let s3Client = AWSS3.default()
        s3Client.getObject(getObjectRequest!) {
            (result, error) in
            var msg: String?
            
            let imageData: Data = result?.body as! Data
            
                if error != nil{
                    msg = "Download image from S3 failed: " + (error as? String ?? "unknown error")
                } else {
                    msg = "Download image from S3 successful:" + key
                }
            
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Download image from S3", message: msg, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                self.present(alert, animated: true)
                
                let downloadedImage: UIImage = UIImage(data: imageData, scale: 1.0)!
                
                self.imageView.image = downloadedImage
            }
            
            
        }
    }
    
    //Mark: UITextFieldDelegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //Disable the Download Image button while editing
        downloadImageButton.isEnabled = false
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //Hide the keyboard
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
        imageKey = keyTextField.text
    }
    
    //Mark: Private Methods
    private func updateSaveButtonState() {
        //Disable the Save Button if the text field is empty.
        let text = keyTextField.text ?? ""
        downloadImageButton.isEnabled = !text.isEmpty
    }
    
    
}
