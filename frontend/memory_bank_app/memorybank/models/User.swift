//
//  user.swift
//  memorybank
//
//  Created by David Sun on 11/5/19.
//  Copyright © 2019 Dubal, Rohan. All rights reserved.
//

import Foundation
import Alamofire

struct UserSession {
    var email: String?
    var token: String?
    var isPatient: Bool?
}

@available(iOS 10.0, *)
func getUserSession() -> UserSession? {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    return appDelegate.userSession
}

@available(iOS 10.0, *)
func setUserSessionToken(jwtToken: String) {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    appDelegate.userSession?.token = jwtToken
}

@available(iOS 10.0, *)
func setUserSessionStatus(isPatient: Bool) {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    appDelegate.userSession?.isPatient = isPatient
}

@available(iOS 10.0, *)
func setUserSessionEmail(email: String) {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    appDelegate.userSession?.email = email
}

//func checkForUserSessionAndRoute() {
//    let appDelegate = UIApplication.shared.delegate as! AppDelegate
//    var rootVC : UIViewController?
//    if let _ = appDelegate.userSession {
//        rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "entrypoint")
//    } else {
//        rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "signinController")
//    }
//    appDelegate.window?.rootViewController = rootVC
//}

