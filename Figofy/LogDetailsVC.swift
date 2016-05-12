//
//  LogDetailsVC.swift
//  Figofy
//
//  Created by Tommy on 09/05/2016.
//  Copyright © 2016 Tommy. All rights reserved.
//

import Foundation
class LogDetailsVC:  UIViewController, UIImagePickerControllerDelegate,UIPickerViewDelegate{
    
    @IBOutlet weak var vælgSøTextField: UITextField!
    @IBOutlet weak var noteTextField: UITextField!
    @IBOutlet weak var agnTextField: UITextField!
    @IBOutlet weak var metodeTextField: UITextField!
    @IBOutlet weak var længdeTextField: UITextField!
    @IBOutlet weak var vægtTextField: UITextField!
    @IBOutlet weak var artTextField: UITextField!
    @IBOutlet weak var addImgUIImage: UIImageView!
    
    var imagePicker: UIImagePickerController!
    override func viewDidLoad() {
        super.viewDidLoad()
//        imagePicker = UIImagePickerController()
//        imagePicker.delegate = self

        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        noteTextField.text = Fish.staticFish.note
        agnTextField.text = "\(Fish.staticFish.bait)"
        metodeTextField.text = Fish.staticFish.method
        længdeTextField.text = "\(Fish.staticFish.length)"
        vægtTextField.text = "\(Fish.staticFish.weight)"
        artTextField.text = Fish.staticFish.species
        
        let imgStr = Fish.staticFish.imageStr
        
        addImgUIImage.image = decodeBase64StringToImage(imgStr)

        
    }
    
    
    @IBAction func BackToProfile(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    @IBAction func saveDetails(sender: AnyObject) {
        let img = encodeToBase64String(self.addImgUIImage.image!)
        let m = Float(længdeTextField.text!)
        let kg = Float(vægtTextField.text!)
        let time = Fish.staticFish.timeCatched
        
        let newFish: Dictionary<String, AnyObject> = [
            "imageStr" : img,
            "length" : m!,
            "species" : artTextField.text!,
            "weight" : kg!,
            "catched" : [
                "bait" : agnTextField.text!,
                "method" : metodeTextField.text!,
                "note" : noteTextField.text!,
                "time_catched" : time
            ]
        ]
        
       let fishRef = DataService.dataService.REF_FISH.childByAppendingPath(Fish.staticFish.fishPostKey)
        fishRef.updateChildValues(newFish)
    }
    
   
}
