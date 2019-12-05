//
//  MessagesViewController.swift
//  memorybank
//
//  Created by David Sun on 11/26/19.
//  Copyright © 2019 Dubal, Rohan. All rights reserved.
//

import UIKit
import Foundation
import Firebase
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
        self.getMessages()
    }
    
    @IBAction func sendClicked(_ sender: Any) {
        self.sendMessage()
    }
    
    func sendMessage() {
        guard let message = self.chatTextField.text, !message.isEmpty else { return }
        guard let email = getUserSession()?.email else { return }
        view.endEditing(true)
        print("er?")
        let db = Firestore.firestore()
        let messageObject = db.collection("messages").document();
        self.chatTextField.text = ""
        messageObject.setData([
            "content": message,
            "from": email,
            "created": FieldValue.serverTimestamp()
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                self.getMessages()
            }
        }
    }
    
    func getMessages() {
        let db = Firestore.firestore()
        let messagesObject = db.collection("messages")
        messagesObject.order(by: "created", descending: false).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                self.messages = []
                for document in querySnapshot!.documents {
                    let id = document.data()
                    self.messages = self.messages + [
                        Message(content: id["content"] as! String, from: id["from"] as! String, created: id["created"] as! Timestamp)
                    ]
                }
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
