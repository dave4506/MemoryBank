//
//  Identification.swift
//  memorybank
//
//  Created by David Sun on 11/26/19.
//  Copyright © 2019 Dubal, Rohan. All rights reserved.
//

import Foundation
import UIKit
import Firebase

struct Identification {
    var id: String
    var image: UIImage
    var guess: String
    var familyLabel: String?
    var familyDescription: String?
    var created: Timestamp
}
