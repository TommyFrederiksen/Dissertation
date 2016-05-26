//
//  FriendsCell.swift
//  Figofy
//
//  Created by Tommy on 09/03/2016.
//  Copyright © 2016 Tommy. All rights reserved.
//

import UIKit

class FriendsCell: UITableViewCell {
    
    @IBOutlet weak var _fullName: UILabel!
    @IBOutlet weak var _email: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configureCell(user: FigofyUser){
        _fullName.text = "\(user.userFirstName) \(user.userLastName)"
        _email.text = user.email
    }
    
}
