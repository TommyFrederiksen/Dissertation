//
//  LogCell.swift
//  Figofy
//
//  Created by Tommy on 18/03/2016.
//  Copyright © 2016 Tommy. All rights reserved.
//

import UIKit

class LogCell: UITableViewCell {
    
    
    @IBOutlet weak var logImageView: UIImageView!
    @IBOutlet weak var beskrivelseLabel: UILabel!
    @IBOutlet weak var datoLabel: UILabel!
  
    @IBOutlet weak var vægt: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    func configureCell(fish: Fish)
    {
        
        datoLabel.text = NSDate.convertToString(time: fish.timeCatched, style: .MediumStyle)
        let img = decodeBase64StringToImage(fish.imageStr)
        logImageView.image = img
        beskrivelseLabel.text = "Art: \(fish.species)"
        vægt.text = "\(fish.weight) Kg"
        
    }
    
    func decodeBase64StringToImage(strEncodedData: String?) -> UIImage {
        if let data = strEncodedData{
            let image = NSData(base64EncodedString: data, options: .IgnoreUnknownCharacters)
            return UIImage(data: image!)!
        }
        else
        {
            return UIImage(named: "Figofy_app_trans")!
        }
        
    }
    
    
}
