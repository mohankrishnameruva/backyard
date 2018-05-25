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
    
    @IBAction func openMap(_ sender: Any) {
    let map = self.storyboard?.instantiateViewController(withIdentifier: "MapViewController") as! UIViewController
        self.navigationController?.pushViewController(map, animated: true)
    }
    @IBOutlet weak var PlusFloatButton: UIButton!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.ShoppingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "listItemTableViewCell", for: indexPath) as! listItemTableViewCell
        
        cell.itemName.text =  ShoppingList[indexPath.row].itemName
        cell.quantity.text =  ShoppingList[indexPath.row].quantity
//        if ShoppingList[indexPath.row].bought!{
//            cell.backgroundColor = UIColor.blue
//        }else{
//            tableView.deselectRow(at: indexPath, animated: true)
//        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(50.0)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        let listItem = self.ShoppingList[indexPath.row]
        let toggledCompletion = listItem.bought
        toggleCellCheckbox(cell, isCompleted: toggledCompletion!)
        listItem.ref?.updateChildValues([
            "bought": toggledCompletion
            ])
        
        
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let groceryItem = ShoppingList[indexPath.row]
            groceryItem.ref?.removeValue()
        }

    }

    func toggleCellCheckbox(_ cell: UITableViewCell, isCompleted: Bool) {
        if !isCompleted {
            cell.accessoryType = .none
            cell.textLabel?.textColor = .black
            cell.detailTextLabel?.textColor = .black
        } else {
            cell.accessoryType = .checkmark
            cell.textLabel?.textColor = .gray
            cell.detailTextLabel?.textColor = .gray
        }
    }
    
    @IBAction func onClickEdit(_ sender: Any) {
        
//        if(shopListTable.isEditing == true)
//        {
//
//            self.navigationItem.rightBarButtonItem?.title = "Done"
//
//            self.AddorMarkBoughtButton.setTitle("Add New Item", for: UIControlState.normal)
//            var selectedRows = shopListTable.indexPathsForSelectedRows
//            for i in selectedRows!{
//                ShoppingList.remove(at: i.row)
//            }
//            shopListTable.reloadData()
//            self.shopListTable.isEditing = false
//            shopListTable.allowsMultipleSelectionDuringEditing = false
//
//        }
//        else
//        {
//            self.shopListTable.isEditing = true
//            self.navigationItem.rightBarButtonItem?.title = "Edit"
//             shopListTable.allowsMultipleSelectionDuringEditing = true
//                self.AddorMarkBoughtButton.setTitle("Delete", for: UIControlState.normal)
//        }
  
       
        
    }
//    @IBAction func onClickSave(_ sender: Any) {
//        
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        let context = appDelegate.persistentContainer.viewContext
//        let entity = NSEntityDescription.entity(forEntityName: "ShoppingList", in: context)
//        var ref: DatabaseReference!
//        
//        ref = Database.database().reference()
//        print(context)
//        do{
//                for i in self.ShoppingList{
//                    let tempItem = ref.child("shopList").child(String(describing: i.itemName))
//                    tempItem.child((String(describing: "itemName"))).setValue(i.itemName)
//                    tempItem.child((String(describing: "quant"))).setValue(i.quantity)
//                }
//        }
//    }
    

    @IBAction func onClickAddItem(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Add New Item", message: "Add New Item", preferredStyle: .alert)
        
        let clickOk = UIAlertAction(title: "OK", style: .default, handler: { alert -> Void in
            let itemName = alertController.textFields![0] as UITextField
            let quantity = alertController.textFields![1] as UITextField
            
            //                let appDelegate = UIApplication.shared.delegate as! AppDelegate
            //                let context = appDelegate.persistentContainer.viewContext
            //                let entity = NSEntityDescription.entity(forEntityName: "ShoppingList", in: context)
            
            let ref = Database.database().reference()
            
            let tempItem = ref.child("shopList").child(String(describing: itemName.text!))
            tempItem.child((String(describing: "itemName"))).setValue(itemName.text)
            tempItem.child((String(describing: "quant"))).setValue(quantity.text)
            tempItem.child((String(describing: "bought"))).setValue(false)
            
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
        
        
        
        
    }
    
    @IBAction func onClickShare(_ sender: UIBarButtonItem) {
        
        //TBD
        
    }
    


    
    @IBOutlet weak var shopListTable: UITableView!
    var ShoppingList:[listItem] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.PlusFloatButton.layer.cornerRadius = 37
        
        self.shopListTable.delegate = self
        self.shopListTable.dataSource = self
        
//        self.navigationController?.navigationBar.items?.removeAll()
        
        self.navigationItem.rightBarButtonItem?.title = "Done"
       self.navigationItem.hidesBackButton = false
self.navigationItem.title = "Nav item Title®"
        self.navigationController?.title = "List view 1"
        
        let nib = UINib.init(nibName: "listItemTableViewCell", bundle: nil)
        shopListTable.register(nib, forCellReuseIdentifier: "listItemTableViewCell")
        do{
            let ref: DatabaseReference! = Database.database().reference()
            let UserAccessRef :DatabaseReference! = ref.child("UserAccessData")
            var userListPath : String =  String(describing: UserDefaults.standard.value(forKey: "loggedinUser")!)
            userListPath = userListPath.data(using: String.Encoding.utf8)!.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
            var UserAccessibleListsId = [String]()
//            ref.observe(.value, with: { snapshot in
//                var updatedItems = [listItem]()
//                for child in snapshot.childSnapshot(forPath: "UserAccessData/" + userListPath).children {
//                    if let temp = child as? DataSnapshot{
//                        let AccesibleLists = self.getAccesibleLists(snapshot:temp)
//                        }
//                    }
//            })
//
    
//             let ref: DatabaseReference! = Database.database().reference()
            ref.observe(.value, with: { snapshot in
                var updatedItems = [listItem]()
                for child in snapshot.childSnapshot(forPath: "shopList").children {
                    if let temp = child as? DataSnapshot{
                        let curItem = listItem(snapshot:temp)
                        updatedItems.append(curItem!)
                    }
                }
//                if child.count == 0 {
//                    ref.child(userListPath)
//
//                    UserDefaults.standard.setValue([userListPath], forKeyPath: "accessibleLists")
//                }
                self.ShoppingList = updatedItems
                self.shopListTable.reloadData()
            })
            shopListTable.allowsMultipleSelectionDuringEditing = false
        
        
        }}
//    func getAccesibleLists(snapshot: DataSnapshot){
//        var AccessibleListIds = [String]()
//        let emailId = String(describing: UserDefaults.standard.value(forKey: "loggedinUser")).data(using: String.Encoding.utf8)!.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
//
//        AccessibleListIds.append(snapshot.value["listId"] as! String)
//
//    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

