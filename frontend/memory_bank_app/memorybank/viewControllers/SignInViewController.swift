//
//  SignInRouteViewController.swift
//  memorybank
//
//  Created by David Sun on 11/25/19.
//  Copyright © 2019 Dubal, Rohan. All rights reserved.
//

import UIKit
import Eureka
import Alamofire

class SignInRouteViewController: FormViewController {

    var username: String?
    var password: String?
    
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
            }
            <<< TextRow("username"){
                // $0.hidden = "$segments != 'Family Member'"
                $0.title = "Email"
                $0.placeholder = "johnAppleseed@umich.edu"
            }.cellUpdate { cell, row in
                self.username = cell.textField.text
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
        guard let username = self.username else { self.handleEmpty(); return }
        guard let password = self.password else { self.handleEmpty(); return }
        
        print("username", username, "password", password)
        
        let parameters = [
            "username": username,
            "password": password,
        ] as Parameters
        
        Alamofire.request("https://memorybank-staging.herokuapp.com/auth/signin", method: .post, parameters: parameters)
            .responseJSON { response in
                print(response)
            }
    }
}
