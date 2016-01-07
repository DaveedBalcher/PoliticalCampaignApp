//
//  Post.swift
//  LiptonForPA
//
//  Created by David Balcher on 11/17/15.
//  Copyright © 2015 Xpressive. All rights reserved.
//

import UIKit

class Post {
    let id: String
    let date: NSDate
    let body: String
    var image: UIImage?
    
    init(id: String, date: NSDate, body: String, image: UIImage?) {
        self.id = id
        self.date = date
        self.body = body
        self.image = image
    }
    
    func isPostWithID(id: String) -> Bool {
        if self.id == id {
            return true
        } else {
            return false
        }
    }
}
