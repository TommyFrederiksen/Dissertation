//
//  SeaListVC.swift
//  Figofy
//
//  Created by Mohammed Joseph Petrelli Salameh on 02/02/16.
//  Copyright © 2016 Tommy. All rights reserved.
//

import UIKit
import CoreData
import Firebase

class SeaListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Variables
    var figofySeas = [FigofySea]()
    
    // MARK: View Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        observeForNewSeas()
        
    }
    
    // MARK: Custom Methods
    func observeForNewSeas () {
        DataService.dataService.REF_SEAS.observeEventType(.Value, withBlock: { snapshot in
            
            
            self.figofySeas = []
            if let snapshots = snapshot.children.allObjects as? [FDataSnapshot] {
                
                for snap in snapshots {
                    
                    print("SNAP: \(snap)")
                    
                    if let seaDict = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        let sea = FigofySea(postKey: key, dictionary: seaDict)
                        self.figofySeas.append(sea)
                    }
                    
                }
                
            }
            
            self.tableView.reloadData()
        })
    }
    
    // MARK: TableView Methods
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return figofySeas.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCellWithIdentifier("FigofySeaCell") as? FigofySeaCell {
            let sea = figofySeas[indexPath.row]
            print(sea.fullAddress)
            cell.configureCell(sea)
            return cell
        } else {
            return FigofySeaCell()
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let sea: FigofySea!
        
        sea = figofySeas[indexPath.row]
        
        print("\(sea.seaName) \(sea.seaPrices)")
        DBPaymentRegister.staticPaymentRegister.seas = sea.seaId
        print(DBPaymentRegister.staticPaymentRegister.seas)
        performSegueWithIdentifier("LakeInformationVC", sender: sea)
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    // MARK: Segue Methods
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "LakeInformationVC" {
            if let lakeInfo = segue.destinationViewController as? LakeInformationVC {
                if let sea = sender as? FigofySea {
                    lakeInfo.sea = sea
                }
            }
        }
    }

}
