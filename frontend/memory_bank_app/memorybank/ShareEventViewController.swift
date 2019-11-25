//
//  ShareEventViewController.swift
//  memorybank
//
//  Created by Stewart Vohra on 11/24/19.
//  Copyright © 2019 Dubal, Rohan. All rights reserved.
//

import UIKit

class ShareEventViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        eventIDField.delegate = self
        userEmailField.delegate = self
        
        //Initialize text fields to nil
        self.eventIDField.text = nil
        self.userEmailField.text = nil
    }
    
    //MARK: Attributes:
    var jwtToken: String?
    
    @IBOutlet weak var eventIDField: UITextField!
    
    @IBOutlet weak var userEmailField: UITextField!
    
    //MARK: Actions:
    
    @IBAction func shareButtonPressed(_ sender: UIButton) {
        guard let eventIDValue =  self.eventIDField.text, !eventIDValue.isEmpty,
        let userEmailValue = self.userEmailField.text, !userEmailValue.isEmpty else {
            let alertController = UIAlertController(title: "Missing information",
                                                    message: "Please enter a valid event ID and user email",
                                                    preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alertController.addAction(okAction)
            
            self.present(alertController, animated: true, completion:  nil)
            return
        }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.jwtToken = appDelegate.getJWTToken()
        
        let json: [String: Any] = ["event_id": self.eventIDField.text ?? "NULL",
                                   "user_email":self.userEmailField.text ?? "NULL"]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        var request = URLRequest(url:URL(string: "Https://memorybank-staging.herokuapp.com/event/share")!)
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
                    let alertController = UIAlertController(title: "Event Successfully Shared", message: "Event Shared. You can share another event or return to home page using the Back button. ",preferredStyle: .alert)
                    
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
