//
//  listItemTableViewCell.swift
//  shoppingList
//
//  Created by Mohan on 24/04/18.
//  Copyright © 2018 Mohan. All rights reserved.
//

import UIKit

class listItemTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var itemName: UITextField!
    @IBOutlet weak var quantity: UITextField!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
 
        
            accessoryType = selected ? .checkmark : .none

    }
    
}
