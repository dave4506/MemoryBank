//
//  Event.swift
//  memorybank
//
//  Created by Stewart Vohra on 11/24/19.
//  Copyright © 2019 Dubal, Rohan. All rights reserved.
//

import Foundation
import UIKit

class Event {
    var name: String
    var description: String
    var location: String
    var startTime: String
    var endTime: String
    var eventID: String
    
    init(name: String, description: String, location: String, startTime: String, endTime: String, eventID: String){
        self.name = name
        self.description = description
        self.location = location
        self.startTime = startTime
        self.endTime = endTime
        self.eventID = eventID
    }
}
