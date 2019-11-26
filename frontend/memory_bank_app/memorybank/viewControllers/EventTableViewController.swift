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

        cell.nameLabel.text = event.name
        cell.infoLabel.text = event.description
        cell.locLabel.text = event.location
        cell.startLabel.text = event.startTime
        cell.endLabel.text = event.endTime
        cell.idLabel.text = event.eventID

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
        
        
        let headers: HTTPHeaders = [
            "Authorization": self.jwtToken ?? "NULL",
            "Accept": "application/json"
        ]

        Alamofire.request("Https://memorybank-staging.herokuapp.com/event", method: .get, headers: headers).validate().responseJSON { response in
            if let json = response.result.value as? [String:Any] {
                print("json successfully created")
                print("JSON: \(json)")
                
                if let currEventsArray = json["events"] as? [[String:Any]] {
                    print("currEvents successfully created")
                    
                    var newEvents = [Event]()
                    for currEvent in currEventsArray {
                        let event_name:String = currEvent["event_name"] as? String ?? "NULL"
                        let event_location:String = currEvent["event_location"] as? String ?? "NULL"
                        let event_description:String = currEvent["event_description"] as? String ?? "NULL"
                        let event_ID:String = currEvent["_id"] as? String ?? "NULL"
                        let evet_start_time:String = currEvent["evet_start_time"] as? String ?? "NULL"
                        let event_end_time:String = currEvent["event_end_time"] as? String ?? "NULL"
                        
                        let event = Event(name: event_name, description: event_description, location: event_location, startTime: evet_start_time, endTime: event_end_time, eventID: event_ID)
                        
                        newEvents += [event]
                    }
                    
                    self.events = newEvents
                    DispatchQueue.main.async(execute: {
                        self.tableView.estimatedRowHeight = 140
                        self.tableView.rowHeight = UITableView.automaticDimension
                        self.tableView.reloadData()
                        self.refreshControl?.endRefreshing()
                    })
                }
            }
        }
}
