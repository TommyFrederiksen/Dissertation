//
//  ClockVC.swift
//  Figofy
//
//  Created by Tommy on 05/02/2016.
//  Copyright © 2016 Tommy. All rights reserved.
//

import UIKit

class ClockVC: UIViewController {
    
    @IBOutlet weak var hoursLayer: Timer!
    @IBOutlet weak var minutesLayer: Timer!
    @IBOutlet weak var secondsLayer: Timer!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func viewWillLayoutSubviews() {
        
    }
    override func viewDidLoad(){
        
        
        
        hoursLayer.animateFromAngle(0, toAngle: 360, duration: 30, relativeDuration: true, completion: { s in
            // TODO: Whatever we wanna do when the timer ends
            
        })
        minutesLayer.animateFromAngle(0, toAngle: 360, duration: 20, relativeDuration: true, completion: { s in
            // TODO: Whatever we wanna do when the timer ends
            
        })
        secondsLayer.animateFromAngle(0, toAngle: 360, duration: 10, relativeDuration: true, completion: { s in
            // TODO: Whatever we wanna do when the timer ends
            
        })
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        hoursLayer.layer.opacity = 0
        minutesLayer.layer.opacity = 0
        secondsLayer.layer.opacity = 0
        print("I WILL APPEAR")
        if !hoursLayer.isAnimating() {
            hoursLayer.animateToAngle(360, duration: 30, completion: nil)
            minutesLayer.animateToAngle(360, duration: 20, completion: nil)
            secondsLayer.animateToAngle(360, duration: 10, completion: nil)
        }
    }
    override func viewDidAppear(animated: Bool) {
        print("I APPEARED")
        UIView.animateWithDuration(2.5) { s in
            
            self.hoursLayer.layer.opacity = 1
            self.minutesLayer.layer.opacity = 1
            self.secondsLayer.layer.opacity = 1
            
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        print("I WILL DISAPPEAR")
        hoursLayer.pauseAnimation()
        minutesLayer.pauseAnimation()
        secondsLayer.pauseAnimation()
    }
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        print("I DISAPPEARED")
    }

    
    
}








