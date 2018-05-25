//
//  LoginController.swift
//  shoppingList
//
//  Created by Mohan on 02/05/18.
//  Copyright © 2018 Mohan. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginController: UIViewController,UICollisionBehaviorDelegate {

    var animator: UIDynamicAnimator!
    var gravity: UIGravityBehavior!
    var collision: UICollisionBehavior!
    
    @IBOutlet weak var MobileNumber: UITextField!
    @IBOutlet weak var Password: UITextField!
    @IBOutlet weak var Submit: UIButton!
    @IBOutlet weak var SignUpButton: UIButton!
    @IBOutlet weak var breakView: UIView!
    @IBOutlet weak var LogindetectorView: UIView!
    
    @IBAction func signUpClicked(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let RegisterViewController = storyBoard.instantiateViewController(withIdentifier: "RegisterViewController") 
        
        self.present(RegisterViewController, animated: true, completion: nil)
    }
    
    func collisionBehavior(_ behavior: UICollisionBehavior, endedContactFor item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?) {
        let temp:String = identifier as! String
        if temp  == "LogindetectorView" {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            
            let navController = storyBoard.instantiateViewController(withIdentifier: "HomeNavigation") as! UIViewController
            self.present(navController, animated:true, completion:nil)
        }
    }
    
    @IBAction func onSubmitClick(_ sender: UIButton) {
        do {
            let email = MobileNumber.text!
            let password = Password.text!
            
   
                    Auth.auth().signIn(withEmail: email,
                                       password: password){ user, error in
                                        if let error = error, user == nil {
                                            let alert = UIAlertController(title: "Sign In Failed",
                                                                          message: error.localizedDescription,
                                                                          preferredStyle: .alert)
                                            
                                            alert.addAction(UIAlertAction(title: "OK", style: .default))
                                            
                                            self.present(alert, animated: true, completion: nil)
                                        }
                                        else{
                                            UserDefaults.standard.set(email, forKey: "loggedinUser")
                                            UserDefaults.standard.set(password, forKey: "password")
                                            self.breakView.removeFromSuperview()
                                            self.collision.removeBoundary(withIdentifier: "breakview" as NSCopying)
                                        }
                    
                }
            }
  
    }
    override func viewDidLoad() {
        super.viewDidLoad()
print(UserDefaults.standard.value(forKey: "loggedinUser"))
        animator = UIDynamicAnimator(referenceView: view)
        gravity = UIGravityBehavior(items: [MobileNumber,Password,Submit,SignUpButton])
        animator.addBehavior(gravity)
        collision = UICollisionBehavior(items: [MobileNumber,Password,Submit,SignUpButton])
        collision.addBoundary(withIdentifier: "breakview" as NSCopying , for: UIBezierPath(rect: self.breakView.frame))
        collision.addBoundary(withIdentifier: "LogindetectorView" as NSCopying , for: UIBezierPath(rect: self.LogindetectorView.frame))

//        collision.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collision)

        
         collision.collisionDelegate = self
        
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
