//
//  CreateEventViewController.swift
//  memorybank
//
//  Created by Stewart Vohra on 11/23/19.
//  Copyright © 2019 Dubal, Rohan. All rights reserved.
//

import UIKit
import Eureka
import Alamofire

class CreateEventViewController: FormViewController {

    var eventName: String?
    var descript: String?
    var location: String?
    var startDate: Date?
    var endDate: Date?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureForm()
    }
    
    @IBAction func dismissClicked(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    func configureForm() {
        form +++ Section()
            <<< TextRow("eventName"){
                // $0.hidden = "$segments != 'Family Member'"
                $0.title = "Event Name"
                $0.placeholder = "Family Reunion"
            }.cellUpdate { cell, row in
                self.eventName = cell.textField.text
            }
            <<< TextAreaRow("description"){
                // $0.hidden = "$segments != 'Family Member'"
                $0.title = "Description"
                $0.placeholder = "What are we gonna do!"
            }.cellUpdate { cell, row in
                self.descript = cell.textView.text
            }
            <<< TextRow("location"){
                // $0.hidden = "$segments != 'Family Member'"
                $0.title = "Location"
                $0.placeholder = "Where will it be?"
            }.cellUpdate { cell, row in
                self.location = cell.textField.text
            }
            <<< DateTimeRow() {
                $0.title = "Start"
            }.cellUpdate { cell, row in
                self.startDate = cell.datePicker.date
            }
            <<< DateTimeRow() {
                $0.title = "End"
            }.cellUpdate { cell, row in
                self.endDate = cell.datePicker.date
            }
            <<< ButtonRow(){
                $0.title = "Create Event"
            }.onCellSelection { cell, row in
                self.saveEvent()
            }
    }
    
    func handleEmpty() {
        
    }
    
    func saveEvent() {
        guard let eventName = self.eventName, !eventName.isEmpty,
        let descript = self.descript, !descript.isEmpty,
        let location = self.location, !location.isEmpty,
            let startDate = self.startDate, let endDate = self.endDate else { self.handleEmpty(); return }
        
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd hh:mm:ss"
        
        let parameters = [
            "event_name": eventName,
            "event_description": descript,
            "event_location": location,
            "event_start_time": df.string(from: startDate),
            "event_end_time": df.string(from: endDate),
        ] as Parameters
        
        let headers = [
            "Authorization": getUserSession()?.token ?? ""
        ] as HTTPHeaders
        
        Alamofire.request("https://memorybank-staging.herokuapp.com/event/create", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { response in
                if let _ = response.error {
                } else {
                    self.dismiss(animated: true)
                }
        }
    }
}
