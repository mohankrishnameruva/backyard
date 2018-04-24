//
//  ViewController.swift
//  shoppingList
//
//  Created by Mohan on 23/04/18.
//  Copyright © 2018 Mohan. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "listItemTableViewCell", for: indexPath) as! listItemTableViewCell

        return cell
        
    }
    

    
    @IBOutlet weak var shopListTable: UITableView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.shopListTable.delegate = self
        self.shopListTable.dataSource = self
//        shopListTable.register(UINib(nibName: "listItemTableViewCell", bundle: nil), forCellReuseIdentifier: "listItem")
        let nib = UINib.init(nibName: "listItemTableViewCell", bundle: nil)
        shopListTable.register(nib, forCellReuseIdentifier: "listItemTableViewCell")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    


}

