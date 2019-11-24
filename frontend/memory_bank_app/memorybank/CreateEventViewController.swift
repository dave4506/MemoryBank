//
//  CreateEventViewController.swift
//  memorybank
//
//  Created by Stewart Vohra on 11/23/19.
//  Copyright © 2019 Dubal, Rohan. All rights reserved.
//

import UIKit

class CreateEventViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //Set text field delegates to self
        eventNameField.delegate = self
        descripField.delegate = self
        locationField.delegate = self
        startTimeField.delegate = self
        endTimeField.delegate = self
        
        //Initialize text fields to nil
        self.eventNameField.text = nil
        self.descripField.text = nil
        self.locationField.text = nil
        self.startTimeField.text = nil
        self.endTimeField.text = nil
    }
    
    //MARK: Attributes:
    
    var jwtToken: String?
    
    @IBOutlet weak var eventNameField: UITextField!
    
    
    @IBOutlet weak var descripField: UITextField!
    
    
    @IBOutlet weak var startTimeField: UITextField!
    
    @IBOutlet weak var locationField: UITextField!
    
    @IBOutlet weak var endTimeField: UITextField!
    
    //MARK: Actions:
    
    @IBAction func saveEvent(_ sender: UIButton) {
        guard let nameValue = self.eventNameField.text, !nameValue.isEmpty,
        let descripValue = self.descripField.text, !descripValue.isEmpty,
        let locationValue = self.locationField.text, !locationValue.isEmpty,
        let startValue = self.startTimeField.text, !startValue.isEmpty,
        let endValue = self.endTimeField.text, !endValue.isEmpty
         else {
            let alertController = UIAlertController(title: "Missing information",
                                                    message: "Please enter valid event name, description, location, starting time, and ending time",
                                                    preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alertController.addAction(okAction)
            
            self.present(alertController, animated: true, completion:  nil)
            return
        }
        
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            self.jwtToken = appDelegate.getJWTToken()
            
            let json: [String: Any] =
                ["event_name": self.eventNameField.text ?? "NULL",
                 "event_description": self.descripField.text ?? "NULL",
                "event_location": self.locationField.text ?? "NULL",
                "event_start_time": self.startTimeField.text ?? "NULL",
                "event_end_time": self.endTimeField.text ?? "NULL"]
            
            let jsonData = try? JSONSerialization.data(withJSONObject: json)
            
            var request = URLRequest(url:URL(string: "Https://memorybank-staging.herokuapp.com/event/create")!)
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
                        let alertController = UIAlertController(title: "Event Successfully Created", message: "Event created. You can create another event or return to home page using the Back button. ",preferredStyle: .alert)
                        
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
