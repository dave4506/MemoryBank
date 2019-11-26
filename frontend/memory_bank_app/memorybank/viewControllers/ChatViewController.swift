//
//  MessagesViewController.swift
//  memorybank
//
//  Created by David Sun on 11/26/19.
//  Copyright © 2019 Dubal, Rohan. All rights reserved.
//

import UIKit
import Foundation
import IHKeyboardAvoiding
import Alamofire

class ChatViewController: UIViewController {
    
    var messages = [Message]()
    @IBOutlet weak var chatView: UITableView!
    @IBOutlet weak var chatTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        KeyboardAvoiding.avoidingView = self.view
        self.hideKeyboardWhenTappedAround()
        let isPatient = getUserSession()?.isPatient ?? false
        self.messages = isPatient ? patient_messages : family_messages
    }
    
    @IBAction func sendClicked(_ sender: Any) {
        self.sendMessage()
    }
    
    func sendMessage() {
        view.endEditing(true)

        let message = self.chatTextField.text ?? ""

        let parameters = [
            "receiver_email": "ffstudios1@gmail.com",
            "message": message,
        ] as Parameters
        
        let headers = [
            "Authorization": getUserSession()?.token ?? ""
        ] as HTTPHeaders
        
        self.messages = self.messages + [Message(content: message, from: "David")]
        self.chatTextField.text = ""
        self.chatView.reloadData()

        Alamofire.request("https://memorybank-staging.herokuapp.com/messaging/send", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { response in
                print(response)
                if let _ = response.error {
                } else {
                    self.chatView.reloadData()
                }
        }
    }
    
    func getMessages() {
        let parameters = [:] as Parameters
        
        let headers = [
            "Authorization": getUserSession()?.token ?? ""
        ] as HTTPHeaders
        
        Alamofire.request("https://memorybank-staging.herokuapp.com/messaging/get", method: .get, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { response in
                if let _ = response.error {
                } else {
                    let payload = (response.value as! [[String:Any]])
                    var newMessages = [Message]()
                    for dict in payload {
                        let curr_message:String = dict["message"] as! String

                        let message = Message(content: curr_message, from: "")

                        newMessages += [message]
                    }
                    self.messages += newMessages
                    self.chatView.reloadData()
                }
        }
    }
}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "chatTableViewCell", for: indexPath) as? ChatTableViewCell  else {
            fatalError("The dequeued cell is not an instance of chatTableViewCell.")
        }

        let message = self.messages[indexPath.row]

        cell.textBody.text = message.content
        cell.from.text = message.from
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
