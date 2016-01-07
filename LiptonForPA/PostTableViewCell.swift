//
//  PostTableViewCell.swift
//  LiptonForPA
//
//  Created by David Balcher on 11/17/15.
//  Copyright © 2015 Xpressive. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKShareKit

class PostTableViewCell: UITableViewCell{
    
    var feedPost: Post? {
        didSet {
            updateUI()
        }
    }
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!

    
    
    func updateUI() {
        dateLabel?.attributedText = nil
        bodyLabel?.attributedText = nil
        
        // load new information about participant
        if let post = self.feedPost {
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "MM-dd-yyyy"
            dateLabel?.text = dateFormatter.stringFromDate(post.date)
            
            bodyLabel?.text = post.body
        }
    }
    
    
//    @IBAction func share() {
//        let shareAlertController = UIAlertController(title: "Share", message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
//        
//    }
}
