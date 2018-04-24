//
//  ViewController.swift
//  shoppingList
//
//  Created by Mohan on 23/04/18.
//  Copyright © 2018 Mohan. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
  
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.ShoppingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        

    
        let cell = tableView.dequeueReusableCell(withIdentifier: "listItemTableViewCell", for: indexPath) as! listItemTableViewCell
        
        cell.itemName.text = ShoppingList[indexPath.row].itemName
        cell.quantity.text = ShoppingList[indexPath.row].quantity
        
        return cell
        
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(50.0)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    @IBAction func onClickSave(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "ShoppingList", in: context)
        
        for item in ShoppingList{
        let newItem = NSManagedObject(entity: entity!, insertInto: context)
        
        
        newItem.setValue(item.itemName, forKey: "itemName")
        newItem.setValue(item.quantity, forKey: "quantity")
        newItem.setValue(item.bought, forKey: "bought")
        }
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
        
        
    }
    
    @IBAction func addNewItem(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Add New Item", message: "Add New Item", preferredStyle: .alert)

        let clickOk = UIAlertAction(title: "OK", style: .default, handler: { alert -> Void in
            let itemName = alertController.textFields![0] as UITextField
            let quantity = alertController.textFields![1] as UITextField
            let addedItem = listItem(itemName:itemName.text!,quantity:quantity.text!,bought:false)
            self.ShoppingList.append(addedItem)
            self.shopListTable.reloadData()
        })
        let clickCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter Item Name"
        }
        alertController.addTextField { (textField2 : UITextField!) -> Void in
            textField2.placeholder = "Enter Quantity"
        }
        alertController.addAction(clickOk)
        alertController.addAction(clickCancel)

        present(alertController, animated: true, completion: nil)
        
       // var popover: UIPopoverController? = nil
//        var popoverContent = self.storyboard?.instantiateViewController(withIdentifier: "NewCategory") as! UIViewController
//        var nav = UINavigationController(rootViewController: popoverContent)
//        nav.modalPresentationStyle = UIModalPresentationStyle.popover
//        var popover = nav.popoverPresentationController
//        popoverContent.preferredContentSize = CGSizeMake(500,600)
//        popover?.delegate = self as! UIPopoverPresentationControllerDelegate
//        popover?.sourceView = self.view
//        popover?.sourceRect = CGRectMake(100,100,0,0)
        
//        self.present(nav, animated: true, completion: nil)
        
        
    }
    
    
    @IBOutlet weak var shopListTable: UITableView!
    func makeShoppingList() -> [listItem] {
        var item1 = listItem(itemName:"Carrots",quantity:"10",bought:false)
        var item2 = listItem(itemName:"bananas",quantity:"10",bought:false)
        var item3 = listItem(itemName:"apples",quantity:"6",bought:false)
        
        let shoppingList:[listItem] = [item1,item2,item3]
        return shoppingList
        
    }
    var ShoppingList:[listItem] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.shopListTable.delegate = self
        self.shopListTable.dataSource = self

        let nib = UINib.init(nibName: "listItemTableViewCell", bundle: nil)
        shopListTable.register(nib, forCellReuseIdentifier: "listItemTableViewCell")

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ShoppingList")
  
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                var savedItem =  listItem(itemName:data.value(forKey: "itemName") as! String, quantity: data.value(forKey: "quantity") as! String , bought: data.value(forKey: "bought") as! Bool)
                self.ShoppingList.append(savedItem)
                print(data.value(forKey: "itemName") as! String)
            }
            
        } catch {
             ShoppingList = self.makeShoppingList()
            print("Failed")
        }
        
        
        
       
        
        shopListTable.allowsMultipleSelectionDuringEditing = true
        shopListTable.setEditing(true, animated: true)
        
        

        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    


}

