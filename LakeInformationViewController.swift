//
//  LakeInformationViewController.swift
//  Figofy
//
//  Created by Tommy on 21/01/2016.
//  Copyright © 2016 Tommy. All rights reserved.
//

import UIKit


class LakeInformationViewController: UIViewController {
    
    
    @IBOutlet weak var oneHourButton: UIButton!
    
    @IBOutlet weak var treeHourButton: UIButton!
    @IBOutlet weak var fiveHourButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        FigofyButton(oneHourButton)
        FigofyButton(treeHourButton)
        FigofyButton(fiveHourButton)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
