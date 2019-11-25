import Foundation
import AWSCognitoIdentityProvider
import AWSS3

class S3ImageUploadViewController : UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // Mark: Properties
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setToolbarHidden(false, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setToolbarHidden(false, animated: true)
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
        let jpegData:Data = selectedImage.jpegData(compressionQuality: 0.95)!
        
        // var key: String
        
        // key = ""
        
        self.uploadImageToS3(imageData: jpegData)
    }
    
    //MARK: - AWS Methods
    func uploadImageToS3(imageData: Data) {
       
        var request = URLRequest(url:URL(string: "Https://memorybank-staging.herokuapp.com/upload/search")!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue(getUserSession()?.token ?? "NULL", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request){ data, response, error in
            guard let _ = data, error == nil else {
                print("NETWORKING ERROR")
                print("Networking error is: ", error)
                return
            }
            if let httpStatus = response as? HTTPURLResponse,
            httpStatus.statusCode != 200 {
                print("HTTP STATUS: \(httpStatus.statusCode)")
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!) as! [String:Any]
                DispatchQueue.main.async(execute: {
                    
                    self.upload(imageData: imageData, urlString: ((json["url"] as! String?)!), mimeType: "image"){ _,_ in print("Done") }
                })
            }
            catch let error as NSError {
                    print("NSError is: ", error)
            }

            
        }
        task.resume()
    }
    
    func upload(imageData: Data, urlString: String, mimeType: String, completion: @escaping (Bool, Error?) -> Void) {
        let requestURL = URL(string: urlString)!
        var request = URLRequest(url: requestURL)
        request.httpMethod = "PUT"
        request.httpBody = imageData
        request.setValue(mimeType, forHTTPHeaderField: "Content-Type")
        request.setValue("\(imageData.count)", forHTTPHeaderField: "Content-Length")
        request.setValue("public-read", forHTTPHeaderField: "x-amz-acl")
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (response, responseObject, error) in
            print(response ?? "response nil")
            print(error ?? "response nil")
            completion(error == nil, error)
        })
        task.resume()
    }
    
}
