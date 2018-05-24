//
//  RegisterViewController.swift
//  shoppingList
//
//  Created by Mohan on 21/05/18.
//  Copyright © 2018 Mohan. All rights reserved.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {

    @IBOutlet weak var EmailId: UITextField!
    @IBOutlet weak var Password: UITextField!
    
    @IBAction func signUpClicked(_ sender: Any) {
        
        Auth.auth().createUser(withEmail: EmailId.text!, password: Password.text!) { user, error in
            if error == nil {
                // 3
                Auth.auth().signIn(withEmail: self.EmailId.text!,
                                   password: self.Password.text!){ user, error in
                                    if let error = error, user == nil {
                                        let alert = UIAlertController(title: "Sign In Failed",
                                                                      message: error.localizedDescription,
                                                                      preferredStyle: .alert)
                                        
                                        alert.addAction(UIAlertAction(title: "OK", style: .default))
                                        
                                        self.present(alert, animated: true, completion: nil)
                                    }
                                    else{
                                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                        
                                        let navController = storyBoard.instantiateViewController(withIdentifier: "navController") as! UINavigationController
                                        self.present(navController, animated:true, completion:nil)
                                    }
                                    
                }
            }
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

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
