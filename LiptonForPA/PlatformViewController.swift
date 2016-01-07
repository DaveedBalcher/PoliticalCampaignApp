//
//  PlatformViewController.swift
//  LiptonForPA
//
//  Created by David Balcher on 11/20/15.
//  Copyright © 2015 Xpressive. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKShareKit

class PlatformViewController: UIViewController {

    @IBOutlet weak var platformTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        platformTextView.contentInset = UIEdgeInsetsMake(20.0,0.0,0,0.0)
        platformTextView.scrollRangeToVisible(NSMakeRange(0, 1))
    }
    
    @IBOutlet weak var likeButton: FBSDKLikeButton!
    
    override func viewWillAppear(animated: Bool) {
        likeButton.objectID = "https://www.facebook.com/LiptonForPA"
    }
}
