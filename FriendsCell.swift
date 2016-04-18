//
//  FriendsCell.swift
//  Figofy
//
//  Created by Tommy on 09/03/2016.
//  Copyright © 2016 Tommy. All rights reserved.
//

import UIKit

class FriendsCell: UICollectionViewCell {
 
        @IBOutlet weak var mainImg: UIImageView!
        @IBOutlet weak var mainLbl: UILabel!
        
        override func awakeFromNib() {
            super.awakeFromNib()
            
        }
        
        func configureCell(image: UIImage, text: String){
            mainImg.image = image
            mainLbl.text = text
        }
    
}
