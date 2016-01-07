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
        
//        self.automaticallyAdjustsScrollViewInsets = false
        platformTextView.contentInset = UIEdgeInsetsMake(20.0,0.0,0,0.0)
        platformTextView.scrollRangeToVisible(NSMakeRange(0, 1))
//        platformTextView.scrollRangeToVisible(NSMakeRange(0, 100))

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var likeButton: FBSDKLikeButton!
    
    override func viewWillAppear(animated: Bool) {
        likeButton.objectID = "https://www.facebook.com/LiptonForPA"
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
