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
import Alamofire

let TEST_USER = "username"
let TEST_PASSWORD = "password"

class SignInViewController: UIViewController {
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    var passwordAuthenticationCompletion: AWSTaskCompletionSource<AWSCognitoIdentityPasswordAuthenticationDetails>?
    var usernameText: String?
    
    var jwtToken: String!
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.password.text = nil
        self.username.text = usernameText
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @IBAction func signInPressed(_ sender: AnyObject) {
        guard let emailValue = self.username.text, !emailValue.isEmpty,
            let passwordValue = self.password.text, !passwordValue.isEmpty else {
                let alertController = UIAlertController(title: "Missing information",
                                                        message: "Please enter a valid user name and password",
                                                        preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alertController.addAction(okAction)
                
                self.present(alertController, animated: true, completion:  nil)
                return
            }
        
            let json: [String: Any] = ["email": self.username.text ?? "NULL", "password": self.password.text ?? "NULL"]
                
            print("signin json is: ", json)
                
            let jsonData = try? JSONSerialization.data(withJSONObject: json)
                
            var request = URLRequest(url:URL(string: "Https://memorybank-staging.herokuapp.com/auth/signin")!)
            request.httpMethod = "POST"
            request.httpBody = jsonData
                
            let task = URLSession.shared.dataTask(with: request)
            { data, response, error in
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
                self.jwtToken = json["token"] as! String?
                    
                print("Signin JWT token is: ", self.jwtToken ?? "NULL")
                    
                DispatchQueue.main.async(execute:{
                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                        appDelegate.setJWTToken(jwtTokenIn: self.jwtToken)
                         
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "entrypoint")
                    self.present(nextViewController, animated:true, completion:nil)
                })
            }
            catch let error as NSError {
                    print("NSError is: ", error)
            }
        }
        task.resume()
    }
}

//extension SignInViewController: AWSCognitoIdentityPasswordAuthentication {
//
//    public func getDetails(_ authenticationInput: AWSCognitoIdentityPasswordAuthenticationInput, passwordAuthenticationCompletionSource: AWSTaskCompletionSource<AWSCognitoIdentityPasswordAuthenticationDetails>) {
//        self.passwordAuthenticationCompletion = passwordAuthenticationCompletionSource
//        DispatchQueue.main.async {
//            if (self.usernameText == nil) {
//                self.usernameText = authenticationInput.lastKnownUsername
//            }
//        }
//    }
//
//    public func didCompleteStepWithError(_ error: Error?) {
//        DispatchQueue.main.async {
//            if let error = error as NSError? {
//                let alertController = UIAlertController(title: error.userInfo["__type"] as? String,
//                                                        message: error.userInfo["message"] as? String,
//                                                        preferredStyle: .alert)
//                let retryAction = UIAlertAction(title: "Retry", style: .default, handler: nil)
//                alertController.addAction(retryAction)
//
//                self.present(alertController, animated: true, completion:  nil)
//            } else {
//                self.username.text = nil
//                self.dismiss(animated: true, completion: nil)
//            }
//        }
//    }
//
//}
