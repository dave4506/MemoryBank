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
    var description: String
    var location: String
    var startTime: String
    var endTime: String
    var eventID: String
    
    init(description: String, location: String, startTime: String, endTime: String, eventID: String){
        self.description = description
        self.location = location
        self.startTime = startTime
        self.endTime = endTime
        self.eventID = eventID
    }
}
