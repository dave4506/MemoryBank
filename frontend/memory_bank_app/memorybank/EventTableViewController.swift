//
//  EventTableViewController.swift
//  memorybank
//
//  Created by Stewart Vohra on 11/24/19.
//  Copyright © 2019 Dubal, Rohan. All rights reserved.
//

import UIKit

class EventTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        self.refreshControl?.addTarget(self, action:
            #selector(EventTableViewController.eventsRefreshed(_:)), for:
            UIControl.Event.valueChanged)
        
        self.refreshEvents()
    }
    
    //MARK: Properties
    var events = [Event]()
    
    var jwtToken: String? = nil

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "EventTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? EventTableViewCell  else {
            fatalError("The dequeued cell is not an instance of EventTableViewCell.")
        }
        
        // Fetches the appropriate meal for the data source layout.
        let event = events[indexPath.row]

        cell.infoTextField.text = event.description
        cell.locationTextField.text = event.location
        cell.startTextField.text = event.startTime
        cell.endTextField.text = event.endTime
        cell.idTextField.text = event.eventID

        return cell
    }
    
    //MARK: Actions
    
    @IBAction func eventsRefreshed(_ sender: UITapGestureRecognizer) {
        self.refreshEvents()
    }
    //MARK: Methods
    func refreshEvents() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.jwtToken = appDelegate.getJWTToken()
        
        let requestURL = "Https://memorybank-staging.herokuapp.com/event"
        var request = URLRequest(url: URL(string: requestURL)!)
        request.httpMethod = "GET"
        //request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue(self.jwtToken ?? "NULL", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let _ = data, error == nil else {
                print("NETWORKING ERROR")
                DispatchQueue.main.async(execute: {
                    self.refreshControl?.endRefreshing()
                })
                return
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                print("HTTP STATUS: \(httpStatus.statusCode)")
                print("HTTP status is: ", httpStatus.description)
                
                DispatchQueue.main.async(execute: {
                    self.refreshControl?.endRefreshing()
                })
                return
            }
            do {
                var newEvents = [Event]()
                let json = try JSONSerialization.jsonObject(with: data!) as! [String:Any]
                print("json returned by get events is: ", json)
                for (index, _) in json {
                    let curr_elt = json[index] as? [String:[String:String]]
                    let curr_dict = curr_elt?["event"]
                    let event = Event(description: curr_dict?["event_description"] ?? "NULL", location: curr_dict?["event_location"] ?? "NULL", startTime: curr_dict?["event_start_time"] ?? "NULL", endTime: curr_dict?["event_end_time"] ?? "NULL", eventID: curr_dict?["event_id"] ?? "NULL")
                    
                    newEvents += [event]
                }
                    
                self.events = newEvents
                self.tableView.estimatedRowHeight = 140
                self.tableView.rowHeight = UITableView.automaticDimension
                self.tableView.reloadData()
                DispatchQueue.main.async(execute: {
                    self.refreshControl?.endRefreshing()
                })
            }
            catch let error as NSError {
                print(error)
            }
        }
        task.resume()
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
