//
//  FindFriendVC.swift
//  Figofy
//
//  Created by Tommy on 26/05/2016.
//  Copyright © 2016 Tommy. All rights reserved.
//
import UIKit
import Foundation
import Firebase

class FindFriendVC: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    
    var friends = [FigofyUser]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        getFriendsFromFirebase()
        
        
    }
    func getFriendsFromFirebase(){
        
        DataService.dataService.REF_USERS.observeEventType(.Value, withBlock: { snap in
            self.friends = []
            print(snap)
            if let snapshot = snap.children.allObjects as? [FDataSnapshot]{
                
                for elements in snapshot {
                    if let userDict = elements.value as? Dictionary<String, AnyObject> {
                        let userData = FigofyUser(postKey: elements.key, dictionary: userDict)
                        self.friends.append(userData)
                        print(self.friends.count)
                        
                    }
                }
            }
            
            
        })
        
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier = "friends"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier,forIndexPath: indexPath) as? FriendsCell
        
        
        cell?.configureCell(self.friends[indexPath.row])
        
        return cell!
        
    }
    
    
    
    @IBAction func BackToProfile(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
        
    }
}





