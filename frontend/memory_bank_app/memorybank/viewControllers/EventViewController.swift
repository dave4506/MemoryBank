//
//  EventViewController.swift
//  memorybank
//
//  Created by David Sun on 11/24/19.
//  Copyright © 2019 Dubal, Rohan. All rights reserved.
//

import UIKit
import JTAppleCalendar
import Alamofire
import ESPullToRefresh

@available(iOS 10.0, *)
class EventViewController: UIViewController {

    @IBOutlet weak var eventTableView: UITableView!
    
    var events = [Event]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpPullToRefresh()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        self.refreshEvents()
    }
    
    func setUpPullToRefresh() {
        self.eventTableView.es.addPullToRefresh {
            [unowned self] in
            self.refreshEvents()
            self.eventTableView.es.stopPullToRefresh()
        }
    }
    
    @IBAction func chatClicked(_ sender: Any) {
    }
    
    func refreshEvents() {
    
        let headers: HTTPHeaders = [
            "Authorization": getUserSession()?.token ?? "NULL",
            "Accept": "application/json"
        ]

        Alamofire.request("https://memorybank-staging.herokuapp.com/event", method: .get, headers: headers).validate().responseJSON { response in
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
                        self.eventTableView.reloadData()
                    })
                }
            }
        }
    }
}

@available(iOS 10.0, *)
extension EventViewController: JTAppleCalendarViewDataSource {
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MM dd"
        let startDate = formatter.date(from: "2018 01 01")!
        let endDate = Date()
        return ConfigurationParameters(startDate: startDate, endDate: endDate)
    }
}

@available(iOS 10.0, *)
extension EventViewController: JTAppleCalendarViewDelegate {
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "dateCell", for: indexPath) as! DateMonthlyCell
        self.calendar(calendar, willDisplay: cell, forItemAt: date, cellState: cellState, indexPath: indexPath)
        return cell
    }
    
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        self.configureCell(view: cell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        configureCell(view: cell, cellState: cellState)
    }

    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        configureCell(view: cell, cellState: cellState)
    }
    
    func configureCell(view: JTAppleCell?, cellState: CellState) {
       guard let cell = view as? DateMonthlyCell  else { return }
       cell.dateLabel.text = cellState.text
       handleCellTextColor(cell: cell, cellState: cellState)
       handleCellSelected(cell: cell, cellState: cellState)
    }
        
    func handleCellTextColor(cell: DateMonthlyCell, cellState: CellState) {
       if cellState.dateBelongsTo != .thisMonth {
          cell.dateLabel.textColor = .lightGray
       }
    }
    func handleCellSelected(cell: DateMonthlyCell, cellState: CellState) {
        if cellState.isSelected {
            cell.selectedView.layer.cornerRadius =  17
            cell.selectedView.isHidden = false
        } else {
            cell.selectedView.isHidden = true
        }
    }
}

@available(iOS 10.0, *)
extension EventViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EventTableViewCell", for: indexPath) as? EventTableViewCell  else {
            fatalError("The dequeued cell is not an instance of EventTableViewCell.")
        }

        let event = events[indexPath.row]

        /**let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd hh:mm:ss"
        
        let startDate = df.date(from: event.startTime)
        let endDate = df.date(from: event.endTime)

        let pdf = DateFormatter()
        pdf.dateFormat = "MMM d, h:mm a"*/
        
        cell.nameLabel.text = event.name
        cell.locLabel.text = event.location
        cell.startLabel.text = event.startTime
        cell.endLabel.text = event.endTime
        /**cell.startLabel.text = pdf.string(from: startDate!)
        cell.endLabel.text = pdf.string(from: endDate!)*/

        return cell
    }
}

