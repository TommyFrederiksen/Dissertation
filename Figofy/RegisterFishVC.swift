//
//  RegisterFishVC.swift
//  Figofy
//
//  Created by Mohammed Joseph Petrelli Salameh on 26/02/16.
//  Copyright © 2016 Tommy. All rights reserved.
//

import UIKit
import Firebase
import ActionSheetPicker_3_0

class RegisterFishVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate, UITextFieldDelegate {

    // MARK: IBOutlets
    @IBOutlet weak var fishImg: UIImageView!
    @IBOutlet weak var uploadButton: UIButton!
    @IBOutlet weak var chooseSpecies: UIButton!
    @IBOutlet weak var chooseWeight: UIButton!
    @IBOutlet weak var chooseLength: UIButton!
    @IBOutlet weak var chooseMethod: UIButton!
    @IBOutlet weak var writeBait: UITextField!
    @IBOutlet weak var writeNote: UITextField!
   
    
    var imagePicker: UIImagePickerController!
    
    var currentPicker: UIPickerView!
    
    // MARK: Variables
    var imageSelected = false
    
    var speciesArray = ["Laks","GuldLaks","Guldørred","Havørred","Regnbueørred","Bækørred","Stør","Torsk","Hvilling","Lange","Aborre","Gede","Skalle","Angiv Selv"]
    
    var methodArray = ["Spinne","Mede","Flue","Trolle","Bombarda"]
    
    var lengthArray: [[Int]]?
    var valuesArray: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        // Do any additional setup after loading the view.
        valuesArray += 0..<10
        lengthArray = [valuesArray,valuesArray,valuesArray]
        
        fishImg.layer.cornerRadius = 2.5
        uploadButton.layer.cornerRadius = 5
        
    }

    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        if let picker = currentPicker {
            picker.hidden = true
        }
        view.endEditing(true)
    }
    
    
    // MARK: UIImagePicker delegate methods
    //when user taps on image it returns it
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        //save image
        fishImg.image = image
        imageSelected = true
    }
    
    // MARK: UITextField delegate methods
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        return true
    }
    
    // MARK: IBActions
    @IBAction func uploadPressed(sender: AnyObject) {
        
        if let speciesTxt = chooseSpecies.currentTitle where speciesTxt != "" && speciesTxt != "Tryk for Art",
            let weightTxt = chooseWeight.currentTitle where weightTxt != "" && weightTxt != "Tryk for Vægt",
            let lengthTxt = chooseLength.currentTitle where lengthTxt != "" && lengthTxt != "Tryk for Længde",
            let methodTxt = chooseMethod.currentTitle where methodTxt != "" && methodTxt != "Tryk for Metode",
            let baitTxt = writeBait.text where baitTxt != "" && baitTxt != "Brugt Agn" {
            
            if let img = fishImg.image where imageSelected == true {
                let imgData = encodeToBase64String(img)
                
                postToFirebase(imgData)
                
                
                chooseSpecies.setTitle("Tryk for Art", forState: .Normal)
                chooseWeight.setTitle("Tryk for Vægt", forState: .Normal)
                chooseLength.setTitle("Tryk for Længde", forState: .Normal)
                chooseMethod.setTitle("Tryk for Metode", forState: .Normal)
                writeBait.text = "Brugt Agn"
                writeNote.text = "Eventuelt Note"
                
                imageSelected = false
                fishImg.image = nil
                
            }
            self.dismissViewControllerAnimated(true, completion: nil)
                
        } else {
            AlertView().showOkayAlert("Check dine indtastninger", message:  "En af følgende mangler, Art, Vægt(kg), længde(cm), metode & agn", style: .Alert, VC: self)
        }
        
    }
    
    @IBAction func addPicBtnPressed(sender: UIButton) {
        //still able to change pic
        sender.setTitle("", forState: .Normal)
        presentViewController(imagePicker, animated: true, completion: nil)
    }
   
    @IBAction func speciesTapped(sender: UIButton) {
        //Species stuff
        let action = ActionSheetStringPicker(title: "Vælg Art", rows: speciesArray, initialSelection: 0, doneBlock: { picker, selectedIndex, selectedValue in
            
                self.chooseSpecies.setTitle("\(selectedValue)", forState: .Normal)
            
            }, cancelBlock: { picker in
                
                self.chooseSpecies.setTitle("Tryk for Art", forState: .Normal)
                
            }, origin: sender.superview)
        
        action.showActionSheetPicker()
    }
    
    
    @IBOutlet weak var weightBtn: UIButton!
    @IBAction func weightTapped(sender: UIButton) {
        //Weight stuff
        let action = ActionSheetDistancePicker(title: "Vælg Vægt", bigUnitString: "kg", bigUnitMax: 99, selectedBigUnit: 1, smallUnitString: "g", smallUnitMax: 9, selectedSmallUnit: 1, target: self, action: Selector("measurementWasSelected:smallUnit:element:"), origin: sender.superview!)
        
        action.showActionSheetPicker()
        
    }
    
    @IBOutlet weak var lengthBtn: UIButton!
    @IBAction func lengthTapped(sender: UIButton) {
        //Length stuff
        let action = ActionSheetMultipleStringPicker(title: "Vælg længde", rows: lengthArray, initialSelection: [0,0,0], doneBlock: {
            picker, values, indexes in
            
                self.chooseLength.setTitle("\(values[0])\(values[1])\(values[2])", forState: .Normal)
            return
            }, cancelBlock: { ActionMultipleStringCancelBlock in
                self.chooseLength.setTitle("Tryk for Længde", forState: .Normal)
            }, origin: sender)
        
        action.showActionSheetPicker()
        
    }
    @IBAction func methodTapped(sender: UIButton) {
        //Method stuff
        let action = ActionSheetStringPicker(title: "Vælg Metode", rows: methodArray, initialSelection: 0, doneBlock: { picker, selectedIndex, selectedValue in
            
                self.chooseMethod.setTitle("\(selectedValue)", forState: .Normal)
            
            }, cancelBlock: { picker in
                
                self.chooseMethod.setTitle("Tryk for Metode", forState: .Normal)
                
            }, origin: sender.superview)
        
        action.showActionSheetPicker()
    }
   
    @IBAction func backBtnPressed(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    // MARK: Custom methods
    
    func measurementWasSelected(bigUnit: NSNumber, smallUnit: NSNumber, element: AnyObject) {
        weightBtn.setTitle("\(bigUnit).\(smallUnit)", forState: .Normal)
        print("measurementWasSelected")
    }
    
    func encodeToBase64String(image: UIImage) -> String {
        return (UIImageJPEGRepresentation(image, 0.2)?.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.Encoding64CharacterLineLength))!
    }
    
    func postToFirebase(imgData: String) {
        
        let kind: String = chooseSpecies.currentTitle!
        let kg = Double(chooseWeight.currentTitle!)!
        let m = Double(chooseLength.currentTitle!)!
        let bait = writeBait.text!
        let method = chooseMethod.currentTitle!
        let note = writeNote.text!
        
        let newFish: Dictionary<String, AnyObject> = [
            "imageStr" : imgData,
            "length" : m,
            "species" : kind,
            "weight" : kg,
            "catched" : [
                "bait" : bait,
                "method" : method,
                "note" : note,
            ]
        ]
        
        DataService.dataService.createFish(newFish)
        
    }
    
    
    
    

}
















