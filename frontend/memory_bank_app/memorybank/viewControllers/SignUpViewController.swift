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
import UIKit
import Eureka
import Alamofire

class SignUpViewController: FormViewController {
    
    var email: String?
    var username: String?
    var password: String?
    var isPatient: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureForm()
    }
    
    func configureForm() {
        form +++ Section("Welcome to MemoryBank")
            <<< SegmentedRow<String>("segments"){
                $0.options = ["Family Member", "Patient"]
                $0.value = "Family Member"
            }.onChange {
                self.isPatient = $0.value == "Patient"
            }
            <<< TextRow(){
                $0.title = "Email"
                $0.placeholder = "johnAppleseed@umich.edu"
            }.cellUpdate { cell, row in
                self.email = cell.textField.text
            }
            <<< TextRow(){
                $0.title = "Username"
                $0.placeholder = "johnAppleseed"
            }.cellUpdate { cell, row in
                self.username = cell.textField.text
            }
            <<< PasswordRow(){
                $0.title = "Password"
                $0.placeholder = "Secret Stuff"
            }.cellUpdate { cell, row in
                self.password = cell.textField.text
            }
            <<< ButtonRow(){
                $0.title = "Sign Up"
            }.onCellSelection { cell, row in
                self.signUp()
            }
    }
    
    func handleEmpty() {
        //TODO
    }
    
    func signUp() {
        guard let username = self.username else { self.handleEmpty(); return }
        guard let password = self.password else { self.handleEmpty(); return }
        guard let email = self.email else { self.handleEmpty(); return }

        print("email", email, "username", username, "password", password)
        
        let parameters = [
            "email": email,
            "displayName": username,
            "password": password,
        ] as Parameters
        
        Alamofire.request("https://memorybank-staging.herokuapp.com/auth/signup", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { response in
                if let _ = response.error {
                    
                } else {
                    Alamofire.request("https://memorybank-staging.herokuapp.com/auth/signin", method: .post, parameters: parameters, encoding: JSONEncoding.default)
                     .responseJSON { response in
                         if let _ = response.error {
                             
                         } else {
                            if let token = (response.value as! [String:Any])["token"] {
                                setUserSessionToken(jwtToken: token as! String)
                                setUserSessionStatus(isPatient: self.isPatient)
                                let rootVC = UIStoryboard(name: "Family", bundle: nil).instantiateInitialViewController()!
                                self.navigationController?.pushViewController(rootVC, animated: true)
                            }
                        }
                     }
                }
            }
    }
}
