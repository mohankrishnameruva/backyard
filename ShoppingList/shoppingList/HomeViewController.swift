//
//  HomeViewController.swift
//  shoppingList
//
//  Created by Mohan on 21/05/18.
//  Copyright © 2018 Mohan. All rights reserved.
//

import UIKit


class HomeViewController: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var ListsCollectionView: UICollectionView!
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCell", for: indexPath) as! HomeListCollectionViewCell
        cell.ListName.text = "ListNumber" + String(indexPath.row)
        
        return cell as UICollectionViewCell
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let ListView = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! UIViewController
       self.navigationController?.pushViewController(ListView, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
ListsCollectionView.delegate = self
        ListsCollectionView.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
