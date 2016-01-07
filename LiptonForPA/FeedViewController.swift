//
//  FeedViewController.swift
//  LiptonForPA
//
//  Created by David Balcher on 11/17/15.
//  Copyright © 2015 Xpressive. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKShareKit

class FeedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - View Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPostsForFeed()
    }
    
    @IBOutlet weak var likeButton: FBSDKLikeButton!
    var refreshControl:UIRefreshControl!
    
    override func viewWillAppear(animated: Bool) {
        configureTableView()
        likeButton.objectID = "https://www.facebook.com/LiptonForPA"
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "refresh")
        self.refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.postFeedTableView.addSubview(refreshControl)
    }
    
    func refresh(sender:AnyObject)
    {
        getPostsForFeed()
        self.refreshControl?.endRefreshing()
        print("reloading")
        
    }

    func configureTableView() {
        postFeedTableView.rowHeight = UITableViewAutomaticDimension
        postFeedTableView.estimatedRowHeight = 160.0
    }
    
    // MARK: - Post Feed TableView
    
    @IBOutlet weak var postFeedTableView: UITableView!
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return fbFeed.count
    }
    
    private struct Storyboard {
        static let CellReuseIdentifier1 = "Post Cell With Image"
        static let CellReuseIdentifier2 = "Post Cell"
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if fbFeed[indexPath.row].image != nil {
            let cell = tableView.dequeueReusableCellWithIdentifier(Storyboard.CellReuseIdentifier1, forIndexPath: indexPath) as! PostWithImageTableViewCell
            
            // Configure Cell
            cell.feedPost = fbFeed[indexPath.row]
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier(Storyboard.CellReuseIdentifier2, forIndexPath: indexPath) as! PostTableViewCell
            
            // Configure Cell
            cell.feedPost = fbFeed[indexPath.row]
            
            return cell
        }
    }
    
    
    // MARK: - Loading Facebook Post Data
    
    typealias FBData = [String: AnyObject]
    
    var fbFeed = [Post]()
    
    func getPostsForFeed() {
        let graphRequest = FBSDKGraphRequest(graphPath: "1056305294403303/posts", parameters: ["fields": "message, story, created_time, picture"], HTTPMethod: "GET")
        graphRequest.startWithCompletionHandler { (connection, result, error) -> Void in
            if error != nil {
                print(error)
            } else {
                if let json : NSDictionary = result as? NSDictionary{
                    if let posts = json["data"] as? NSArray {
                        for postData in posts {
                            var postID: String? = nil
                            var postDate: NSDate? = nil
                            var postBody: String? = nil
                            if let postInfo = postData as? NSDictionary {
                                if let idvalue = postInfo["id"] as? String {
                                    postID = idvalue
                                }
                                if let dateString = postInfo["created_time"] as? String {
                                    let formatter = NSDateFormatter()
                                    formatter.locale = NSLocale(localeIdentifier: "US_en")
                                    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZ"
                                    if let date = formatter.dateFromString(dateString) {
                                        postDate = date
                                    }
                                }
                                if let message = postInfo["message"] as? String {
                                    postBody = message
                                }
                                if let imageLocation = postInfo["picture"] as? String {
                                    if let imageURL = NSURL(string: imageLocation) {
                                        self.getDataFromUrl(imageURL, completion: { (data, response, error) in
                                            if error == nil && data != nil && postID != nil {
                                                if let picture = UIImage(data: data!) {
                                                    for post in self.fbFeed {
                                                        if post.isPostWithID(postID!) {
                                                            post.image = picture
                                                            self.postFeedTableView.reloadData()
                                                        }
                                                    }
                                                }
                                            } else {
                                                print("Error getting post image \(error)")
                                            }
                                        })
                                    }
                                }
                                if postID != nil && postDate != nil && postBody != nil {
                                    self.fbFeed.append(Post(id: postID!, date: postDate!, body: postBody!, image: nil))
                                }
                            }
                        }
                    }
                }
                self.postFeedTableView.reloadData()
            }
        }
    }
    
    func getDataFromUrl(url:NSURL, completion: ((data: NSData?, response: NSURLResponse?, error: NSError? ) -> Void)) {
        NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
            completion(data: data, response: response, error: error)
            }.resume()
    }
}
