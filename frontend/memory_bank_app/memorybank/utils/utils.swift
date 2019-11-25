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

func uploadImageToS3(imageData: Data) {
   
    var request = URLRequest(url:URL(string: "Https://memorybank-staging.herokuapp.com/upload/search")!)
    request.httpMethod = "GET"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    request.addValue(getUserSession()?.token ?? "NULL", forHTTPHeaderField: "Authorization")
    
    let task = URLSession.shared.dataTask(with: request){ data, response, error in
        guard let _ = data, error == nil else {
            print("NETWORKING ERROR")
            print("Networking error is: ", error)
            return
        }
        if let httpStatus = response as? HTTPURLResponse,
        httpStatus.statusCode != 200 {
            print("HTTP STATUS: \(httpStatus.statusCode)")
            return
        }
        
        do {
            let json = try JSONSerialization.jsonObject(with: data!) as! [String:Any]
            DispatchQueue.main.async(execute: {
                
                upload(imageData: imageData, urlString: ((json["url"] as! String?)!), mimeType: "image"){ _,_ in print("Done") }
            })
        }
        catch let error as NSError {
                print("NSError is: ", error)
        }

        
    }
    task.resume()
}

func upload(imageData: Data, urlString: String, mimeType: String, completion: @escaping (Bool, Error?) -> Void) {
    let requestURL = URL(string: urlString)!
    var request = URLRequest(url: requestURL)
    request.httpMethod = "PUT"
    request.httpBody = imageData
    request.setValue(mimeType, forHTTPHeaderField: "Content-Type")
    request.setValue("\(imageData.count)", forHTTPHeaderField: "Content-Length")
    request.setValue("public-read", forHTTPHeaderField: "x-amz-acl")
    let task = URLSession.shared.dataTask(with: request, completionHandler: { (response, responseObject, error) in
        print(response ?? "response nil")
        print(error ?? "response nil")
        completion(error == nil, error)
    })
    task.resume()
}
