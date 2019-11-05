//
//  MockUser.swift
//  memorybank
//
//  Created by Benjamin Turner on 11/5/19.
//  Copyright © 2019 Dubal, Rohan. All rights reserved.
//

import Foundation
import MessageKit

struct MockUser: SenderType, Equatable {
    var senderId: String
    var displayName: String
}
