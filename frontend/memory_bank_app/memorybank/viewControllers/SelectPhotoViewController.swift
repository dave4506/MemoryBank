//
//  selectPhoto.swift
//  memorybank
//
//  Created by Benjamin Turner on 11/25/19.
//  Copyright © 2019 Dubal, Rohan. All rights reserved.
//

import Foundation
import AWSCognitoIdentityProvider
import AWSS3

class SelectPhotoViewController : UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // Mark: Properties
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.useImageLibrary()
    }

    @IBAction func useImageLibrary() {
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
        let jpegData:Data = selectedImage.jpegData(compressionQuality: 0.95)!
        
        uploadSearch(imageData: jpegData)
    }
}
