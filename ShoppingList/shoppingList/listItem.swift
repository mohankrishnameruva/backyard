//
//  listItem.swift
//  shoppingList
//
//  Created by Mohan on 24/04/18.
//  Copyright © 2018 Mohan. All rights reserved.
//


import Foundation
class listItem {
    var itemName:String
    var quantity:String
    var bought:Bool
    init(itemName:String,quantity:String,bought:Bool) {
        self.itemName = itemName
        self.quantity = quantity
        self.bought = bought
    }
}
