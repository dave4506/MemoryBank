//
//  MessageTableViewController.swift
//  memorybank
//
//  Created by Stewart Vohra on 11/25/19.
//  Copyright © 2019 Dubal, Rohan. All rights reserved.
//

import UIKit
import Alamofire

class MessageTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        self.refreshControl?.addTarget(self, action:
        #selector(MessageTableViewController.refreshMessages(_:)), for:
        UIControl.Event.valueChanged)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return messages.count
    }
    
    //MARK: Attributes
    var messages = [Message]()
    
    var jwtToken: String?

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "MessageTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MessageTableViewCell  else {
            fatalError("The dequeued cell is not an instance of MessageTableViewCell.")
        }
        
        // Fetches the appropriate meal for the data source layout.
        let message = messages[indexPath.row]
        
        cell.messageLabel.text = message.message

        return cell
    }
    
    //MARK: Actions
    @IBAction func refreshMessages(_ sender: UITapGestureRecognizer) {
        self.messagesRefreshed()
    }
    
    //MARK: Methods
    func messagesRefreshed(){
        self.jwtToken = getUserSession()?.token ?? "NULL"
        
        let headers: HTTPHeaders = [
            "Authorization": self.jwtToken ?? "NULL",
            "Accept": "application/json"
        ]
        
        Alamofire.request("Https://memorybank-staging.herokuapp.com/messaging/get", method: .get, headers: headers).validate().responseJSON { response in
                if let json = response.result.value as? [[String:Any]] {
                    print("json successfully created")
                    print("JSON: \(json)")
                    
                    var newMessages = [Message]()
                    for dict in json {
                        let curr_message:String = dict["message"] as! String
                        
                        let message = Message(message_in: curr_message)
                        
                        newMessages += [message]
                    }
                    
                } else {
                    print("json creation failed")
            }
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
