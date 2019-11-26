//
//  chat.swift
//  memorybank
//
//  Created by David Sun on 11/26/19.
//  Copyright © 2019 Dubal, Rohan. All rights reserved.
//

import Foundation

let family_messages = [
    Message(content: "Hey, we found a box of old photos! We will be bringing them over next week!", from: "Susan"),
    Message(content: "Sweet! Excited to see it!", from: "Jennifer"),
    Message(content: "Are we going to need to bring food?", from: "Joe"),
    Message(content: "I think yeah.", from: "Susan"),
    Message(content: "We are 10 minutes out!", from: "Joe"),
]

let patient_messages = family_messages + [
    Message(content: "Excited!", from: "David"),
]
