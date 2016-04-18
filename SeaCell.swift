//
//  FigofySeaCell.swift
//  Figofy
//
//  Created by Mohammed Joseph Petrelli Salameh on 02/02/16.
//  Copyright © 2016 Tommy. All rights reserved.
//

import UIKit

class FigofySeaCell: UITableViewCell {
    
    // MARK: IBOutlets
    @IBOutlet weak var seaName: UILabel!
    @IBOutlet weak var seaAddress: UILabel!
    //@IBOutlet weak var seaStreetName: UILabel!
    //@IBOutlet weak var seaStreetNumber: UILabel!
    //@IBOutlet weak var seaZipCode: UILabel!
    //@IBOutlet weak var seaCity: UILabel!
    //@IBOutlet weak var seaProfileImgUrl: UIImageView!
    //@IBOutlet weak var seaCoverImgUrl: UIImageView!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    // MARK: Custom Methods
    func configureCell (sea: FigofySea) {
        seaName.text = sea.seaName
        seaAddress.text = sea.fullAddress
//        seaStreetName.text = sea.seaStreetName
//        seaStreetNumber.text = "\(sea.seaStreetNumber)"
//        seaZipCode.text = "\(sea.seaZipCode)"
//        seaCity.text = sea.seaCity
    }
    
}
