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
        }
    }
}
