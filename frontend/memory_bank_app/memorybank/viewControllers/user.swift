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
    var userName: String!
    var token: String?
}

func checkForUserSessionAndRoute() {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var rootVC : UIViewController?
    print("here?")
    if let _ = appDelegate.userSession {
        print("here?")
        rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "entrypoint")
    } else {
        rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "signinController")
    }
    appDelegate.window?.rootViewController = rootVC
}

