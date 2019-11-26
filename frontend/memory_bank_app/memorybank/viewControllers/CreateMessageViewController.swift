//
//  CreateMessageViewController.swift
//  memorybank
//
//  Created by Stewart Vohra on 11/26/19.
//  Copyright © 2019 Dubal, Rohan. All rights reserved.
//

import UIKit

class CreateMessageViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //Set text field delegates to self
        recieverEmailField.delegate = self
        messageField.delegate = self
               
        //Initialize text fields to nil
        self.recieverEmailField.text = nil
        self.messageField.text = nil
    }
    
    //MARK: Properties
     var jwtToken: String?
    
    @IBOutlet weak var recieverEmailField: UITextField!
    
    @IBOutlet weak var messageField: UITextField!
    
    //MARK: Actions
    
    @IBAction func sendMessagePressed(_ sender: UIButton) {
        guard let recieverEmailValue = self.recieverEmailField.text, !recieverEmailValue.isEmpty,
        let messageValue = self.messageField.text, !messageValue.isEmpty
         else {
            let alertController = UIAlertController(title: "Missing information",
                                                    message: "Please enter valid message and reciever email",
                                                    preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alertController.addAction(okAction)
            
            self.present(alertController, animated: true, completion:  nil)
            return
        }
        
            self.jwtToken = getUserSession()?.token ?? "NULL"
            
            let json: [String: Any] =
                ["receiver_email": self.recieverEmailField.text ?? "NULL",
                 "message": self.messageField.text ?? "NULL"]
            
            let jsonData = try? JSONSerialization.data(withJSONObject: json)
            
            var request = URLRequest(url:URL(string: "Https://memorybank-staging.herokuapp.com/messaging/send")!)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.addValue(self.jwtToken ?? "NULL", forHTTPHeaderField: "Authorization")
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

                    DispatchQueue.main.async(execute: {
                        let alertController = UIAlertController(title: "Message Successfully Sent", message: "Message sent. You can send another message or return to home page using the Back button. ",preferredStyle: .alert)
                        
                        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                        alertController.addAction(okAction)
                        
                        self.present(alertController, animated: true, completion:  nil)
                    })
                }
                task.resume()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
