//
//  LogVC.swift
//  Figofy
//
//  Created by Tommy on 08/03/2016.
//  Copyright © 2016 Tommy. All rights reserved.
//

import Foundation
import UIKit
import Firebase


class LogVC: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    
    @IBOutlet weak var logTableView: UITableView!
    var user: FigofyUser!
    
    var fish = [Fish]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logTableView.delegate = self
        logTableView.dataSource = self
        observerForLog()
    }
    
    
    func observerForLog()
    {
        
        self.fish = []
        DataService.dataService.REF_USER_CURRENT.childByAppendingPath("fish").observeEventType(.ChildAdded, withBlock: { fishIds in
            
            //print("\(fishIds.key)")
            DataService.dataService.REF_FISH.childByAppendingPath(fishIds.key).observeSingleEventOfType(.Value, withBlock: {
                fishSnaps in
                
                if let fishDict = fishSnaps.value as? Dictionary<String, AnyObject> {
                    
                    let fishData = Fish(postKey: fishIds.key, dictionary: fishDict)
                    self.fish.append(fishData)
                
                }
                
                
                self.logTableView.reloadData()
                
                
                
            })
            
        })
    }
    
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // MARK: return the number of rows
        return fish.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "logCell"
        if let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as? LogCell {
            
            let fish = self.fish[indexPath.row]
            
            cell.configureCell(fish)
            
            return cell
            
        } else {
            return UITableViewCell()
        }
        
    }
    
    @IBAction func BackToProfile(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
    
    
    
}
