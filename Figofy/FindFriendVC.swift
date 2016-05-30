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

class FindFriendVC: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate
{
    
    var friends = [FigofyUser]()
    var filteredFriends = [FigofyUser]()
    var isInSearchMode = false
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        getFriendsFromFirebase()
        
        
    }
    func getFriendsFromFirebase(){
        
        DataService.dataService.REF_USERS.observeEventType(.Value, withBlock: { snap in
            self.friends = []
            //print(snap)
            if let snapshot = snap.children.allObjects as? [FDataSnapshot]{
                
                for elements in snapshot {
                    if let userDict = elements.value as? Dictionary<String, AnyObject> {
                        let userData = FigofyUser(postKey: elements.key, dictionary: userDict)
                        self.friends.append(userData)
                        print(self.friends.count)
                        
                    }
                }
                self.tableView.reloadData()
            }
            
            
        })
        
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isInSearchMode{
            return filteredFriends.count
        }
        return friends.count
        
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier = "friends"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier,forIndexPath: indexPath) as? FriendsCell
        
        if isInSearchMode{
            cell?.configureCell(self.filteredFriends[indexPath.row])
        }else{
            cell?.configureCell(self.friends[indexPath.row])
        }
        
        return cell!
        
    }
    
    var user: FigofyUser!
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        if isInSearchMode{
            user = self.filteredFriends[indexPath.row]
        }else{
            user = self.friends[indexPath.row]
        }
        requestAlert("Ansøg om venskab til", msg: " \(user.userFirstName)")
        
    }
    
    func requestAlert(title: String, msg: String){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .Alert)
        let actionOK = UIAlertAction(title: "Ok", style: .Default, handler: {(action) in
            DataService.dataService.addRequestToUser(self.user)
            
            self.tableView.reloadData()
        })
        
        
        let actionCancel = UIAlertAction(title: "Cancel", style: .Default, handler: {(action) in
            self.tableView.reloadData()
        })
        alert.addAction(actionOK)
        alert.addAction(actionCancel)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    
    
    
    @IBAction func BackToProfile(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == ""{
            isInSearchMode = false
            self.tableView.reloadData()
        } else{
            isInSearchMode = true
            let lower = searchBar.text!.lowercaseString
            filteredFriends = friends.filter({$0.userFirstName.lowercaseString.rangeOfString(lower) != nil})
            self.tableView.reloadData()
        }
    }
    
    
}





