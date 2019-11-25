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
import Eureka
import Alamofire

class SignInViewController: FormViewController {

    var email: String?
    var password: String?
    var isPatient: Bool = false
    
<<<<<<< HEAD
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureForm()
        // Do any additional setup after loading the view.
    }

    func configureForm() {
        form +++ Section("Let's get you started")
            <<< SegmentedRow<String>("segments"){
                $0.options = ["Family Member", "Patient"]
                $0.value = "Family Member"
            }.onChange {
                self.isPatient = $0.value == "Patient"
            }
            <<< TextRow("username"){
                // $0.hidden = "$segments != 'Family Member'"
                $0.title = "Email"
                $0.placeholder = "johnAppleseed@umich.edu"
            }.cellUpdate { cell, row in
                self.email = cell.textField.text
            }
            <<< PasswordRow("password"){
                // $0.hidden = "$segments != 'Family Member'"
                $0.title = "Password"
                $0.placeholder = "Secret Stuff"
            }.cellUpdate { cell, row in
                self.password = cell.textField.text
            }
            <<< ButtonRow(){
                $0.title = "Log In"
            }.onCellSelection { cell, row in
                self.signIn()
            }
    }
    
    func handleEmpty() {
        //TODO
    }
    
    func signIn() {
        guard let email = self.email else { self.handleEmpty(); return }
        guard let password = self.password else { self.handleEmpty(); return }
        
        print("email", email, "password", password)
        
        let parameters = [
            "email": email,
            "password": password,
        ] as Parameters
        
        Alamofire.request("https://memorybank-staging.herokuapp.com/auth/signin", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { response in
                print(response)
                if let _ = response.error {
                    
                } else {
                    if let token = (response.value as! [String:Any])["token"] {
                        setUserSessionToken(jwtToken: token as! String)
                        setUserSessionStatus(isPatient: self.isPatient)
                        let rootVC = UIStoryboard(name: "Family", bundle: nil).instantiateInitialViewController()!
                        self.navigationController?.pushViewController(rootVC, animated: true)
                    }
                }
=======
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
>>>>>>> c64ea9c... Refactored SignIn.ViewController
        }
        task.resume()
    }
}
