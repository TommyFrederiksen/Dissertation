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
        observerForFeed()
        currentUser()
        let formatter = NSDateFormatter()
        formatter.locale = NSLocale(localeIdentifier: "Europe/Copenhagen")
        formatter.dateFormat = "E, dd MMM yyyy HH:mm:ss Z"
        let date = formatter.dateFromString("Thu, 04 Sep 2014 10:50:12 0000") as? NSDate!
        print(date)
        


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
                print(DBPaymentRegister.staticPaymentRegister.user)

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
