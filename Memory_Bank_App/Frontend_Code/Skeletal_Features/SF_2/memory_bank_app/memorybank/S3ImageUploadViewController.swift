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
        let jpegData:Data = selectedImage.jpegData(compressionQuality: 0.95)!
        
        var key: String
        
        key = ""
        
        key = self.uploadImageToS3(imageData: jpegData)
    }
    
    //MARK: - AWS Methods
    func uploadImageToS3(imageData: Data) -> String{
       
        let pool = AWSCognitoIdentityUserPool(forKey: CognitoUserPoolsSignInProviderKey)
        var username: String = (pool.currentUser()?.username)!
        username = username.replacingOccurrences(of: ".", with: "-")
        
        let s3Client = AWSS3.default()
        let putObjectRequest = AWSS3PutObjectRequest()
        putObjectRequest?.bucket = s3Bucket
        let key = username + "/images/" + randomString(length: 8) + ".jpeg"
        putObjectRequest?.key = key
        putObjectRequest?.body = imageData
        putObjectRequest?.contentType = "image/jpeg"
        putObjectRequest?.contentLength = imageData.count as NSNumber
        
        s3Client.putObject(putObjectRequest!){
            (result, error) in
            
            var msg: String?
        
            if error != nil{
                msg = "Upload image to S3 failed: " + (error as? String ?? "unknown error")
            } else {
                msg = "Upload image to S3 successful:" + key
            }
            
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Upload image to S3", message: msg, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                self.present(alert, animated: true)
            }
        }
        
        return key
    }
    
    
}
