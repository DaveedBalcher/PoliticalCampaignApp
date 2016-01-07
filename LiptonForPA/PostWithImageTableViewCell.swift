//
//  PostWithImageTableViewCell.swift
//  LiptonForPA
//
//  Created by David Balcher on 11/17/15.
//  Copyright © 2015 Xpressive. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKShareKit

class PostWithImageTableViewCell: UITableViewCell {
    
    var feedPost: Post? {
        didSet {
            updateUI()
        }
    }

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    
    
    func updateUI() {
        dateLabel?.attributedText = nil
        bodyLabel?.attributedText = nil
        postImageView?.image = nil
        
        // load new information about participant
        if let post = self.feedPost {
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "MM-dd-yyyy"
            dateLabel?.text = dateFormatter.stringFromDate(post.date)
            
            bodyLabel?.text = post.body
            
            if post.image != nil {
                postImageView?.image = post.image
            }
        }
    }


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
