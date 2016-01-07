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
        } else {
            loginButton.readPermissions = ["email", "public_profile"]
            loginButton.delegate = self
        }
    }
    
    var readyToTransition = true
    
    override func viewDidAppear(animated: Bool) {
        if FBSDKAccessToken.currentAccessToken() != nil && readyToTransition {
            self.performSegueWithIdentifier("post login segue", sender: self)
        }
    }
    
        // MARK: - Facebook Login
    
    @IBOutlet weak var loginButton: FBSDKLoginButton!
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
            print("logged in: \(result)")
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("logged out from facebook")
    }
    
}



