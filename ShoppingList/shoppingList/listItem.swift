//
//  listItem.swift
//  shoppingList
//
//  Created by Mohan on 24/04/18.
//  Copyright © 2018 Mohan. All rights reserved.
//


import Foundation
import Firebase
class listItem {
    let ref : DatabaseReference?
    var _itemName:String?
    var itemName: String{
        get{
            return _itemName!        }
        set(temp){
            _itemName = temp
        }
    }
    
    var _quantity: String?
    var quantity:String?
    {
        get{
            return _quantity!
        }
        set(temp2){
            _quantity = temp2
        }
    }
    var _bought:Bool?
    var bought:Bool?{
        get{
            return _bought!
        }
        set(temp3){
            _bought = temp3
        }
    }
    init(itemName:String,quantity:String,bought:Bool) {
        self.ref = nil
        self.itemName = itemName
        self.quantity = quantity
        self.bought = bought
        
    }
    init?(snapshot: DataSnapshot) {
  
            let value = snapshot.value as? [String: AnyObject]
        let name = value!["itemName"] as? String
        let quant = value!["quant"] as? String
        let bought = value!["bought"]
   
        
        self.ref = snapshot.ref
        self.itemName = name!
        self.quantity = quant
        self.bought = true

    }
}
