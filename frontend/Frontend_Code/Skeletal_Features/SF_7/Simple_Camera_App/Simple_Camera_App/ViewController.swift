//
//  ViewController.swift
//  Simple_Camera_App
//
//  Created by Stewart Vohra on 10/18/19.
//  Copyright © 2019 Stewart Vohra. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    
    var selectButton = CustomButton()
    var takeButton = CustomButton()

    override func viewDidLoad()
    {
        super.viewDidLoad()
        let gradient = CAGradientLayer()

        gradient.frame = view.bounds
        let color1 = UIColor(hue: 0.5667, saturation: 0.61, brightness: 0.23, alpha: 1.0)
        let color2 = UIColor(hue: 0, saturation: 0.01, brightness: 0.57, alpha: 1.0)
        gradient.colors = [color2.cgColor, color1.cgColor]
        self.view.layer.insertSublayer(gradient, at: 0)
        
        setupButtonConstraints()
        addButtonActions()
        
        // Do any additional setup after loading the view.
        if !UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera)
        {
            let alert = UIAlertController(title: "My Alert", message: "Camera not avaliable on this device. ", preferredStyle: .alert)
            self.present(alert, animated: true, completion: nil)
        } else if !UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.savedPhotosAlbum)
        {
            let alert = UIAlertController(title: "My Alert", message: "Saved photos album not avaliable on this device. ", preferredStyle: .alert)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setToolbarHidden(true, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setToolbarHidden(false, animated: true)
    }
    
    func setupButtonConstraints(){
        view.addSubview(selectButton)
        selectButton.setTitle("Select Photo", for: .normal)
        selectButton.translatesAutoresizingMaskIntoConstraints = false
        selectButton.heightAnchor.constraint(equalToConstant: 70).isActive = true
        selectButton.widthAnchor.constraint(equalToConstant: 400).isActive = true
        selectButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        selectButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 120).isActive = true
        view.addSubview(takeButton)
        takeButton.setTitle("Take Photo", for: .normal)
        takeButton.translatesAutoresizingMaskIntoConstraints = false
        takeButton.heightAnchor.constraint(equalToConstant: 70).isActive = true
        takeButton.widthAnchor.constraint(equalToConstant: 400).isActive = true
        takeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        takeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200).isActive = true
        
        
    }
    
    func addButtonActions() {
        selectButton.addTarget(self, action: #selector(selectPhoto), for: .touchUpInside)
        takeButton.addTarget(self, action: #selector(takePhoto), for: .touchUpInside)
    }

    @objc func selectPhoto() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .savedPhotosAlbum
        present(pickerController, animated: true)
    }
    
    
    @objc func takePhoto() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .camera
        pickerController.cameraCaptureMode = .photo
        present(pickerController, animated: true)
    }
   
    @IBOutlet var imageView: UIImageView!
    
    // MARK: - UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        
        // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        imageView.image = selectedImage
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    
    
}

