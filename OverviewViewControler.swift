//
//  OverviewViewControler.swift
//  Figofy
//
//  Created by Tommy on 20/01/2016.
//  Copyright © 2016 Tommy. All rights reserved.
//

import UIKit


class OverviewViewControler: UIViewController {
    
    @IBOutlet weak var lakeViewButton: UIButton!
    
    @IBOutlet weak var profileButton: UIButton!
    
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        FigofyButton(lakeViewButton)
        FigofyButton(profileButton)
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
