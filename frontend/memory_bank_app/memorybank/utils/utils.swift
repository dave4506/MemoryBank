//
//  utils.swift
//  creko
//
//  Created by Vohra, Ajay on 10/20/19.
//  Copyright © 2019 Dubal, Rohan. All rights reserved.
//

import Foundation
import UIKit
import AWSS3
import AWSCore
import AWSRekognition

struct Labels: Codable {
  var labelModelVersion: String
  var labels: [label]
  var orientationCorrection : Int
}

struct label: Codable {
    var confidence : String
    var instances : String
    var name : String
    var parents : String
}

func randomString(length: Int) -> String {
  let letters = "abcdefghijklmnopqrstuvwxyz0123456789"
  return String((0..<length).map{ _ in letters.randomElement()! })
}

func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
}

func uploadSearch(imageData: Data) {
   
    var request = URLRequest(url:URL(string: "Https://memorybank-staging.herokuapp.com/upload/search")!)
    request.httpMethod = "GET"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    request.addValue("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRhIjp7ImlkIjoiNWRkYjIyMTBiMjFiMzcwMDBmYTMwZGU2IiwiZW1haWwiOiJtaWx0OTgyMDAyQHlhaG9vLmNvbSIsImRpc3BsYXlOYW1lIjoibWlsdDk4MjAwMkB5YWhvby5jb20ifSwiaWF0IjoxNTc0NzI1MzE3LCJleHAiOjE1NzQ3Mjg5MTd9.8NBUGyZJJ-Iu8xyOAL69-AAhqzLsrS2VUrMNC2WWZGQ" , forHTTPHeaderField: "Authorization")
    
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
                print(json)
                upload(imageData: imageData, urlString: ((json["url"] as! String?)!), mimeType: "image/jpeg"){ _,_ in print("Done") }
                //searchRekognize()
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

func searchRekognize() {
    var request = URLRequest(url:URL(string: "Https://memorybank-staging.herokuapp.com/search")!)
    request.httpMethod = "GET"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    request.addValue("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRhIjp7ImlkIjoiNWRkYjIyMTBiMjFiMzcwMDBmYTMwZGU2IiwiZW1haWwiOiJtaWx0OTgyMDAyQHlhaG9vLmNvbSIsImRpc3BsYXlOYW1lIjoibWlsdDk4MjAwMkB5YWhvby5jb20ifSwiaWF0IjoxNTc0NzI1MzE3LCJleHAiOjE1NzQ3Mjg5MTd9.8NBUGyZJJ-Iu8xyOAL69-AAhqzLsrS2VUrMNC2WWZGQ" , forHTTPHeaderField: "Authorization")
    
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
                
                print(json["url"] as! String?)
            })
        }
        catch let error as NSError {
                print("NSError is: ", error)
        }

        
    }
    
    task.resume()
}

func uploadFace(imageData: Data, name: String) {
   
    var request = URLRequest(url:URL(string: "Https://memorybank-staging.herokuapp.com/upload/search")!)
    request.httpMethod = "GET"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    request.addValue("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRhIjp7ImlkIjoiNWRkYjIyMTBiMjFiMzcwMDBmYTMwZGU2IiwiZW1haWwiOiJtaWx0OTgyMDAyQHlhaG9vLmNvbSIsImRpc3BsYXlOYW1lIjoibWlsdDk4MjAwMkB5YWhvby5jb20ifSwiaWF0IjoxNTc0NzIxNTM0LCJleHAiOjE1NzQ3MjUxMzR9.IMUVWjf0NtaRtSDhn7N7Wr2HtGVACFN0H-xecQZQIM4" , forHTTPHeaderField: "Authorization")
    
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
                searchRekognize()
            })
        }
        catch let error as NSError {
                print("NSError is: ", error)
        }

        
    }
    
    task.resume()
    
    
}

func uploadRekognize(name : String) {
    var request = URLRequest(url:URL(string: "Https://memorybank-staging.herokuapp.com/rekognize")!)
    request.httpMethod = "POST"
    //request.httpBody = name
    request.addValue("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRhIjp7ImlkIjoiNWRkYjIyMTBiMjFiMzcwMDBmYTMwZGU2IiwiZW1haWwiOiJtaWx0OTgyMDAyQHlhaG9vLmNvbSIsImRpc3BsYXlOYW1lIjoibWlsdDk4MjAwMkB5YWhvby5jb20ifSwiaWF0IjoxNTc0NzIxNTM0LCJleHAiOjE1NzQ3MjUxMzR9.IMUVWjf0NtaRtSDhn7N7Wr2HtGVACFN0H-xecQZQIM4" , forHTTPHeaderField: "Authorization")
    
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
                
                print(json["url"] as! String?)
            })
        }
        catch let error as NSError {
                print("NSError is: ", error)
        }

        
    }
    
    task.resume()
}

func uploadFile(imageData: Data) {

    let access = "AKIAI662ZZJULL7WKBDQ"
    let secret = "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"
    let credentials = AWSStaticCredentialsProvider(accessKey: access, secretKey: secret)
    let configuration = AWSServiceConfiguration(region: AWSRegionType.USEast2, credentialsProvider: credentials)

    AWSServiceManager.default().defaultServiceConfiguration = configuration

    let s3BucketName = "memory-bank"
    let remoteName = randomString(length: 12)+".jpeg"
    print("REMOTE NAME : ",remoteName)

    let expression = AWSS3TransferUtilityUploadExpression()
    expression.progressBlock = { (task, progress) in
        DispatchQueue.main.async(execute: {
            // Update a progress bar
        })
    }

   var completionHandler: AWSS3TransferUtilityUploadCompletionHandlerBlock?
    completionHandler = { (task, error) -> Void in
        DispatchQueue.main.async(execute: {
            // Do something e.g. Alert a user for transfer completion.
            // On failed uploads, `error` contains the error object.
        })
    }

    let transferUtility = AWSS3TransferUtility.default()
    transferUtility.uploadData(imageData, bucket: s3BucketName, key: remoteName, contentType: "image/jpeg", expression: expression, completionHandler: completionHandler).continueWith { (task) -> Any? in
        if let error = task.error {
            print("Error : \(error.localizedDescription)")
        }

        if task.result != nil {
            let url = URL(string:"s3.console.aws.amazon.com/s3/buckets")
            let publicURL = url?.appendingPathComponent(s3BucketName).appendingPathComponent(remoteName)
            if let absoluteString = publicURL?.absoluteString {
                // Set image with URL
                print("Image URL : ",absoluteString)
            }
        }
        
        //sendImageToRekognition(remoteName: remoteName)

        return nil
    }

}

func sendImageToRekognition(selectedImage : UIImage) -> String{
    
    let access = "AKIAI662ZZJULL7WKBDQ"
    let secret = "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"
    let credentials = AWSStaticCredentialsProvider(accessKey: access, secretKey: secret)
    let configuration = AWSServiceConfiguration(region: AWSRegionType.USEast2, credentialsProvider: credentials)
    var string = ""

    AWSServiceManager.default().defaultServiceConfiguration = configuration
    
    let rekognitionClient = AWSRekognition.default()
        
    let image = AWSRekognitionImage()
    image!.bytes = selectedImage.jpegData(compressionQuality: 0.7)
    
    guard let request = AWSRekognitionDetectLabelsRequest() else {
        puts("Unable to initialize AWSRekognitionDetectLabelsRequest.")
        return "Unable to initialize AWSRekognitionDetectLabelsRequest."
    }

    request.image = image
    request.maxLabels = 1
    request.minConfidence = 90
    
    rekognitionClient.detectLabels(request) { (response:AWSRekognitionDetectLabelsResponse!, error: Error?) in
        if error == nil {
            print(response?.labels![0].name as Any)
            string = (response?.labels![0].name)!
        }
        
    }
    
    return string
    
//    rekognitionObject?.detectLabels(searchRequest!){
//        (result, error) in
//        if error != nil{
//            print(error!)
//            return
//        }
//
//        let task = rekognitionObject?.detectLabels(searchRequest!);
//        print(task?.result)
//
//    }
}
