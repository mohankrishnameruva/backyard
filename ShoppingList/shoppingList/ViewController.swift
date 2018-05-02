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
import FirebaseDatabase

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.ShoppingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "listItemTableViewCell", for: indexPath) as! listItemTableViewCell
        if let _ = ShoppingList[indexPath.row].value(forKey: "itemName"){
            cell.itemName.text = try ShoppingList[indexPath.row].value(forKey: "itemName") as! String
            cell.quantity.text = try ShoppingList[indexPath.row].value(forKey: "quantity") as! String
        
        }
        
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
        var ref: DatabaseReference!
        
        ref = Database.database().reference()
        print(context)
            do {
                try context.save()
                let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ShoppingList")
                let records3:[Any]
                var result = [NSManagedObject]()
                do{
                    records3 = try context.fetch(request)
                    if let records2 = records3 as? [NSManagedObject] {
                        for i in records2{
                            ref.child("shopList").child(String(describing: i.value(forKey: "itemName"))).setValue(i.value(forKey: "quantity"))
                        }
                    }
                    
                }
                catch{
                }
                
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
           
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let entity = NSEntityDescription.entity(forEntityName: "ShoppingList", in: context)

            
            let newItem = NSManagedObject(entity: entity!, insertInto: context)
            newItem.setValue(itemName.text! , forKeyPath: "itemName")
            newItem.setValue(quantity.text! , forKeyPath: "quantity")
            newItem.setValue(true , forKeyPath: "bought")
            self.ShoppingList.append(newItem)
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
//    func makeShoppingList() -> [listItem] {
//        var item1 = listItem(itemName:"Carrots",quantity:"10",bought:false)
//        var item2 = listItem(itemName:"bananas",quantity:"10",bought:false)
//        var item3 = listItem(itemName:"apples",quantity:"6",bought:false)
//
//        let shoppingList:[listItem] = [item1,item2,item3]
//        return shoppingList
//
//    }
    var ShoppingList:[NSManagedObject] = []
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
        let records3:[Any]
        var result = [NSManagedObject]()
        do{
            records3 = try context.fetch(request)
            if let records2 = records3 as? [NSManagedObject] {
                ShoppingList = records2

                    }
   
            }
        catch{
        }
        
        
        
        
        
        shopListTable.allowsMultipleSelectionDuringEditing = true
        shopListTable.setEditing(true, animated: true)
        
        
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
}

