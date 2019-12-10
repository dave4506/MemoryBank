//
//  utils.swift
//  creko
//
//  Created by Vohra, Ajay on 10/20/19.
//  Copyright © 2019 Dubal, Rohan. All rights reserved.
//

import Foundation

func randomString(length: Int) -> String {
  let letters = "abcdefghijklmnopqrstuvwxyz0123456789"
  return String((0..<length).map{ _ in letters.randomElement()! })
}

func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
}

class S3UploadCredentials: NSObject {
    var bucket: String
    var key: String
    var credential: String
    var date: String
    var algorithm: String
    var policy: String
    var signature: String

    init(key: String, policy: String, algorithm: String,credential: String, date: String, signature: String, bucket: String) {
        self.bucket = bucket
        self.key = key
        self.credential = credential
        self.algorithm = algorithm
        self.date = date
        self.policy = policy
        self.signature = signature
    }
}
