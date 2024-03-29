//
// Copyright 2014-2018 Amazon.com,
// Inc. or its affiliates. All Rights Reserved.
//
// Licensed under the Amazon Software License (the "License").
// You may not use this file except in compliance with the
// License. A copy of the License is located at
//
//     http://aws.amazon.com/asl/
//
// or in the "license" file accompanying this file. This file is
// distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, express or implied. See the License
// for the specific language governing permissions and
// limitations under the License.
//

import UIKit
import AWSCognitoIdentityProvider
import Firebase

@available(iOS 10.0, *)
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    var userSession: UserSession?;
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // checkForUserSessionAndRoute()
        self.userSession = UserSession(email: nil, token: nil, isPatient: nil)
        UNUserNotificationCenter.current().delegate = self
        FirebaseApp.configure()
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:
    }
    
//    func refreshCredentials() {
//
//        print("call logins")
//        self.pool?.logins().continueOnSuccessWith{ (task) -> AnyObject? in
//            DispatchQueue.main.async(execute: {
//                let logins = task.result
//                self.identityProvider = CognitoUserPoolIdentityProvider(tokens: logins as? [String : String])
//                self.credentialsProvider = AWSCognitoCredentialsProvider(regionType: CognitoIdentityUserPoolRegion,
//                                                                         identityPoolId: CognitoIdentityPoolId,
//                                                                         identityProviderManager: self.identityProvider)
//                self.configuration = AWSServiceConfiguration(region: CognitoIdentityUserPoolRegion,
//                                                             credentialsProvider: self.credentialsProvider)
//                AWSServiceManager.default().defaultServiceConfiguration = self.configuration
//
//                self.pool!.currentUser()!.getSession().continueOnSuccessWith{ (task) -> AnyObject? in
//                    DispatchQueue.main.async(execute: {
//                        self.session = task.result
//                        print(self.session!.idToken!.tokenString as Any)
//                    })
//                    return nil
//                }
//            })
//            return nil
//        }
//    }
//
//    func getTokens() -> AWSCognitoIdentityUserSession? {
//        return self.session
//    }
}

@available(iOS 10.0, *)
extension AppDelegate: UNUserNotificationCenterDelegate {

    // called when user interacts with notification (app not running in foreground)
    func userNotificationCenter(_ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse, withCompletionHandler
        completionHandler: @escaping () -> Void) {

        // do something with the notification
        print(response.notification.request.content.userInfo)

        // the docs say you should execute this asap
        return completionHandler()
    }

    // called if app is running in foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent
        notification: UNNotification, withCompletionHandler completionHandler:
        @escaping (UNNotificationPresentationOptions) -> Void) {

        // show alert while app is running in foreground
        return completionHandler(UNNotificationPresentationOptions.alert)
    }
}


// MARK:- AWSCognitoIdentityInteractiveAuthenticationDelegate protocol delegate

//extension AppDelegate: AWSCognitoIdentityInteractiveAuthenticationDelegate {
//
//    func startPasswordAuthentication() -> AWSCognitoIdentityPasswordAuthentication {
//        if (self.navigationController == nil) {
//            self.navigationController = self.storyboard?.instantiateViewController(withIdentifier: "signinController") as? UINavigationController
//        }
//
//        if (self.signInViewController == nil) {
//            self.signInViewController = self.navigationController?.viewControllers[0] as? SignInViewController
//        }
//
//        DispatchQueue.main.async {
//            self.navigationController!.popToRootViewController(animated: true)
//            if (!self.navigationController!.isViewLoaded
//                || self.navigationController!.view.window == nil) {
//                self.window?.rootViewController?.present(self.navigationController!,
//                                                         animated: true,
//                                                         completion: nil)
//            }
//
//        }
//        return self.signInViewController!
//    }
//
//    func startMultiFactorAuthentication() -> AWSCognitoIdentityMultiFactorAuthentication {
//        if (self.mfaViewController == nil) {
//            self.mfaViewController = MFAViewController()
//            self.mfaViewController?.modalPresentationStyle = .popover
//        }
//        DispatchQueue.main.async {
//            if (!self.mfaViewController!.isViewLoaded
//                || self.mfaViewController!.view.window == nil) {
//                //display mfa as popover on current view controller
//                let viewController = self.window?.rootViewController!
//                viewController?.present(self.mfaViewController!,
//                                        animated: true,
//                                        completion: nil)
//
//                // configure popover vc
//                let presentationController = self.mfaViewController!.popoverPresentationController
//                presentationController?.permittedArrowDirections = UIPopoverArrowDirection.left
//                presentationController?.sourceView = viewController!.view
//                presentationController?.sourceRect = viewController!.view.bounds
//            }
//        }
//        return self.mfaViewController!
//    }
//
//    func startRememberDevice() -> AWSCognitoIdentityRememberDevice {
//        return self
//    }
//}
//
//// MARK:- AWSCognitoIdentityRememberDevice protocol delegate
//
//extension AppDelegate: AWSCognitoIdentityRememberDevice {
//
//    func getRememberDevice(_ rememberDeviceCompletionSource: AWSTaskCompletionSource<NSNumber>) {
//        self.rememberDeviceCompletionSource = rememberDeviceCompletionSource
//        DispatchQueue.main.async {
//            // dismiss the view controller being present before asking to remember device
//            self.window?.rootViewController!.presentedViewController?.dismiss(animated: true, completion: nil)
//            let alertController = UIAlertController(title: "Remember Device",
//                                                    message: "Do you want to remember this device?.",
//                                                    preferredStyle: .actionSheet)
//
//            let yesAction = UIAlertAction(title: "Yes", style: .default, handler: { (action) in
//                self.rememberDeviceCompletionSource?.set(result: true)
//            })
//            let noAction = UIAlertAction(title: "No", style: .default, handler: { (action) in
//                self.rememberDeviceCompletionSource?.set(result: false)
//            })
//            alertController.addAction(yesAction)
//            alertController.addAction(noAction)
//
//            self.window?.rootViewController?.present(alertController, animated: true, completion: nil)
//        }
//    }
//
//    func didCompleteStepWithError(_ error: Error?) {
//        DispatchQueue.main.async {
//            if let error = error as NSError? {
//                let alertController = UIAlertController(title: error.userInfo["__type"] as? String,
//                                                        message: error.userInfo["message"] as? String,
//                                                        preferredStyle: .alert)
//                let okAction = UIAlertAction(title: "ok", style: .default, handler: nil)
//                alertController.addAction(okAction)
//                DispatchQueue.main.async {
//                    self.window?.rootViewController?.present(alertController, animated: true, completion: nil)
//                }
//            }
//        }
//    }
//
//
//}
