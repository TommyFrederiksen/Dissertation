//
//  EventTableVC.swift
//  Figofy
//
//  Created by Tommy on 04/02/2016.
//  Copyright © 2016 Tommy. All rights reserved.
//

import UIKit

class EventTableVC: UITableViewController {
    
    // MARK: Properties
    
    var events = [Event]()
    
    func loadSampleEvents()
    {
        let photo1 = UIImage(named: "EventImage1")!
        let photo2 = UIImage(named: "EventImage2")!
        let photo3 = UIImage(named: "EventImage3")!
        let photo4 = UIImage(named: "EventImage4")!
        let photo5 = UIImage(named: "EventImage5")!
        let photo6 = UIImage(named: "EventImage6")!
        let photo7 = UIImage(named: "EventImage7")!
        let photo8 = UIImage(named: "EventImage8")!
        let photo9 = UIImage(named: "EventImage9")!
        let photo10 = UIImage(named: "EventImage10")!
        //let event1 = Event(name: "Fiske Konkurance!!!", description: "Første premie = 5.000DKK", dateTime: "marts 01, 2016")
        let event1 = Event(name: "Fiske Konkurance!!!", description: "Første premie = 5.000DKK", dateTime: "marts 01, 2016",photo: photo1)
        let event2 = Event(name: "Dagen Største Fisk!!", description: "Første premie = 1 Måned Fri Fiskeri i Søen", dateTime: "marts 03, 2016",photo: photo2)
        let event3 = Event(name: "Fiske Marathon :)", description: "fisk i 12 timer betal kun for 5 timer", dateTime: "marts 07, 2016",photo: photo3)
        let event4 = Event(name: "Fiske Marathon :)", description: "fisk i 12 timer betal kun for 5 timer", dateTime: "marts 07, 2016",photo: photo4)
        let event5 = Event(name: "Fiske Marathon :)", description: "fisk i 12 timer betal kun for 5 timer", dateTime: "marts 07, 2016",photo: photo5)
        let event6 = Event(name: "Fiske Marathon :)", description: "fisk i 12 timer betal kun for 5 timer", dateTime: "marts 07, 2016",photo: photo6)
        let event7 = Event(name: "Fiske Marathon :)", description: "fisk i 12 timer betal kun for 5 timer", dateTime: "marts 07, 2016",photo: photo7)
        let event8 = Event(name: "Fiske Marathon :)", description: "fisk i 12 timer betal kun for 5 timer", dateTime: "marts 07, 2016",photo: photo8)
        let event9 = Event(name: "Fiske Marathon :)", description: "fisk i 12 timer betal kun for 5 timer", dateTime: "marts 07, 2016",photo: photo9)
        let event10 = Event(name: "Fiske Marathon :)", description: "fisk i 12 timer betal kun for 5 timer", dateTime: "marts 07, 2016",photo: photo10)
        
        
        events += [event1]
        events += [event2]
        events += [event3]
        events += [event4]
        events += [event5]
        events += [event6]
        events += [event7]
        events += [event8]
        events += [event9]
        events += [event10]
      
        
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //loadSampleEvents()
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // MARK: return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // MARK: return the number of rows
        return 15
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "EventTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        
        cell.textLabel?.text = "Ikke tilgængelig i Beta"
//        let event = events[indexPath.row]
//        // MARK: configures the cell
//        cell.photoImageView.image = event._photo
//        cell.photoImageView.layer.cornerRadius = 45
//        cell.photoImageView.clipsToBounds = true
//        cell.nameLabel.text = event._name
//        cell.descriptionLabel.text = event._description
//        cell.timeAndDateLabel.text = event._dateTime
        
        
        return cell
    }
    
    
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the specified item to be editable.
    return true
    }
    */
    
    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
    // Delete the row from the data source
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    } else if editingStyle == .Insert {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    }
    */
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the item to be re-orderable.
    return true
    }
    */
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
