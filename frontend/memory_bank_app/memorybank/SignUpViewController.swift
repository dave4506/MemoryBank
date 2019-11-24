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

class SignUpViewController: UIViewController, UITextFieldDelegate {
    //MARK: Attributes:
    
    //var pool: AWSCognitoIdentityUserPool?
    var sentTo: String?
    
    var jwtToken: String!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    
    @IBOutlet weak var displayTextField: UITextField!
    
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    //MARK: view Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.pool = AWSCognitoIdentityUserPool.init(forKey: CognitoUserPoolsSignInProviderKey)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    //MARK: Actions
    
    @IBAction func signUp(_ sender: UIButton) {
        guard let emailValue = self.emailTextField.text, !emailValue.isEmpty,
            let passwordValue = self.passwordTextField.text, !passwordValue.isEmpty,
            let displayNameValue = self.displayTextField.text, !displayNameValue.isEmpty else {
                let alertController = UIAlertController(title: "Missing Required Fields",
                                                        message: "Email, Display Name, and Password are required for registration.",
                                                        preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alertController.addAction(okAction)
                
                self.present(alertController, animated: true, completion:  nil)
                return
        }
        
            let json: [String: Any] = ["email": self.emailTextField.text ?? "NULL", "displayName": self.displayTextField.text ?? "NULL", "password": self.passwordTextField.text ?? "NULL"]
        
            print("signup json is: ", json)
            
            let jsonData = try? JSONSerialization.data(withJSONObject: json)
            
            var request = URLRequest(url:URL(string: "Https://memorybank-staging.herokuapp.com/auth/signup")!)
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
                self.jwtToken = json["message"] as! String?
                
                print("Signin JWT token is: ", self.jwtToken ?? "NULL")
            }
            catch let error as NSError {
                print("NSError is: ", error)
            }
        }
        task.resume()
        
        let alertController = UIAlertController(title: "Sign Up Successful",
                                                message: "User with email: \(String(describing: emailTextField.text)) successfully signed up. You can now go back to the sign in screen and sign in using your email as your username and password",
                                                preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true, completion:  nil)
    }
    
    /**override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let signUpConfirmationViewController = segue.destination as? ConfirmSignUpViewController {
            signUpConfirmationViewController.sentTo = self.sentTo
            signUpConfirmationViewController.user = self.pool?.getUser(self.username.text!)
        }
    }*/
    
    /**@IBAction func signUp(_ sender: AnyObject) {
        
        guard let emailValue = self.emailTextField.text, !emailValue.isEmpty,
            let passwordValue = self.passwordTextField.text, !passwordValue.isEmpty,
            let displayNameValue = self.displayNameTextField.text, !displayNameValue.isEmpty else {
                let alertController = UIAlertController(title: "Missing Required Fields",
                                                        message: "Username / Password are required for registration.",
                                                        preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alertController.addAction(okAction)
                
                self.present(alertController, animated: true, completion:  nil)
                return
        }
        
            let json: [String: Any] = ["email": self.emailTextField.text ?? "NULL", "displayName": self.displayNameTextField.text ?? "NULL", "password": self.passwordTextField.text ?? "NULL"]
        
            print("signup json is: ", json)
            
            let jsonData = try? JSONSerialization.data(withJSONObject: json)
            
            var request = URLRequest(url:URL(string: "Https://memorybank-staging.herokuapp.com/auth/signup")!)
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
                self.jwtToken = json["message"] as! String?
                
                print("Signin JWT token is: ", self.jwtToken ?? "NULL")
            }
            catch let error as NSError {
                print("NSError is: ", error)
            }
        }
        task.resume()
        
        /**var attributes = [AWSCognitoIdentityUserAttributeType]()
        
        if let phoneValue = self.phone.text, !phoneValue.isEmpty {
            let phone = AWSCognitoIdentityUserAttributeType()
            phone?.name = "phone_number"
            phone?.value = phoneValue
            attributes.append(phone!)
        }
        
        if let emailValue = self.email.text, !emailValue.isEmpty {
            let email = AWSCognitoIdentityUserAttributeType()
            email?.name = "email"
            email?.value = emailValue
            attributes.append(email!)
        }
        
        
        
        //sign up the user
        self.pool?.signUp(userNameValue, password: passwordValue, userAttributes: attributes, validationData: nil).continueWith {[weak self] (task) -> Any? in
            guard let strongSelf = self else { return nil }
            DispatchQueue.main.async(execute: {
                if let error = task.error as NSError? {
                    let alertController = UIAlertController(title: error.userInfo["__type"] as? String,
                                                            message: error.userInfo["message"] as? String,
                                                            preferredStyle: .alert)
                    let retryAction = UIAlertAction(title: "Retry", style: .default, handler: nil)
                    alertController.addAction(retryAction)
                    
                    self?.present(alertController, animated: true, completion:  nil)
                } else if let result = task.result  {
                    // handle the case where user has to confirm his identity via email / SMS
                    if (result.user.confirmedStatus != AWSCognitoIdentityUserStatus.confirmed) {
                        strongSelf.sentTo = result.codeDeliveryDetails?.destination
                        strongSelf.performSegue(withIdentifier: "confirmSignUpSegue", sender:sender)
                    } else {
                        let _ = strongSelf.navigationController?.popToRootViewController(animated: true)
                    }
                }
                
            })
            return nil
        }*/
    }*/
}
