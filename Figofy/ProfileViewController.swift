//
//  ProfileViewController.swift
//  Figofy
//
//  Created by Tommy on 21/01/2016.
//  Copyright © 2016 Tommy. All rights reserved.
//

import UIKit

import Firebase


class ProfileViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var feedTableView: UITableView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    var clock = Clock()
    var user: FigofyUser!
    var fish = [Fish]()
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        profileImageView.image = UIImage(named: "man")
        profileImageView.layer.cornerRadius = profileImageView.frame.width/2
        profileImageView.clipsToBounds = true
        feedTableView.delegate = self
        feedTableView.dataSource = self
        currentUser()
        // setting up Queue for Async tread Loading will continue on its own
        dispatch_async(dispatch_get_global_queue(Int(QOS_CLASS_USER_INITIATED.rawValue), 0)){
            self.observerForFeed()
            print("Initiated Queue: \(QOS_CLASS_USER_INITIATED.rawValue)")
        }
        
        
      
        


    }
    func scrollToFirstRow() {
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        self.feedTableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: .Top, animated: true)
    }
    
    func currentUser()
    {
        
        DataService.dataService.REF_USER_CURRENT.observeSingleEventOfType(.Value, withBlock: { snapshot in
            if let userDict = snapshot.value as?Dictionary<String, AnyObject>{
                
                let _user = FigofyUser(postKey: snapshot.key, dictionary: userDict)
                self.user = _user
                self.nameLbl.text = "\(self.user.userFirstName)"
                DBPaymentRegister.staticPaymentRegister.name = "\(self.user.userFirstName) \(self.user.userLastName)"
                DBPaymentRegister.staticPaymentRegister.user = self.user.facebookId
                print("Current User have run \(NSDate.init())")

            }
        })
        
    }
    
    func observerForFeed()
    {
        DataService.dataService.REF_FISH.observeEventType(.Value, withBlock:
            { snapshot in
                
                self.fish = []
                if let snapshots = snapshot.children.allObjects as? [FDataSnapshot]
                {
                    for element in snapshots
                    {
                        
                        if let fishDict = element.value as? Dictionary<String, AnyObject>
                        {
                            let key = element.key
                            let _fish = Fish(postKey: key, dictionary: fishDict)
                            _fish.coughtBy = ""// connect fisherman name to this string.
                            self.fish.append(_fish)
                            
                        }
                        
                    }
                }
                self.fish = self.fish.reverse()
                self.feedTableView.reloadData()
                print("observeFeed have run \(NSDate.init())")
                

        })
        
        
    }
    
    
        
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.fish.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "FeedCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as? FeedCell
        
        cell?.configureCell(self.fish[indexPath.row])
        
        return cell!
        
    }
}
