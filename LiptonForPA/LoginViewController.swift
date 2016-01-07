//
//  ViewController.swift
//  LiptonForPA
//
//  Created by David Balcher on 11/16/15.
//  Copyright © 2015 Xpressive. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    // MARK: - ViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if FBSDKAccessToken.currentAccessToken() != nil {
            // user already has access token
//            loginButton.hidden = true
        } else {
            loginButton.readPermissions = ["email", "public_profile"]
            loginButton.delegate = self
        }
    }
    
//    override func viewWillAppear(animated: Bool) {
////            self.logUserData()
//        
//    }
    
    var readyToTransition = true
    
    override func viewDidAppear(animated: Bool) {
        if FBSDKAccessToken.currentAccessToken() != nil && readyToTransition {
            self.performSegueWithIdentifier("post login segue", sender: self)
//            let mainVC = FeedViewController()
//            mainVC.modalPresentationStyle = UIModalPresentationStyle.FullScreen
//            mainVC.modalTransitionStyle = UIModalTransitionStyle.CoverVertical
//            self.presentViewController(mainVC, animated: true, completion: nil)
        }
    }
    
//    func logout() {
//        FBSDKLoginManager().logOut()
//    }
    
        // MARK: - Facebook Login
    
    @IBOutlet weak var loginButton: FBSDKLoginButton!
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
//        if Reachability.isConnectedToNetwork() {
            print("logged in: \(result)")
//        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("logged out from facebook")
    }
    
//    typealias FBData = [String: AnyObject]
//    
//    var userData = FBData()
//    
//    func logUserData() {
//        let graphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name"])
//        graphRequest.startWithCompletionHandler { (connection, result, error) -> Void in
//            if error != nil {
//                print(error)
//            } else {
//                let resultdict = result as? NSDictionary
//                if let idvalue = resultdict?["id"] as? String {
//                    self.userData["id"] = idvalue
//                }
//                if let name = resultdict?["name"] as? String {
//                    self.userData["name"] = name
//                }
//            }
//        }
//    }

    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}



