//
//  RegisterViewController.swift
//  Messenger Application
//
//  Created by لمياء فالح الدوسري on 28/05/1443 AH.
//

import UIKit
import Firebase
import FirebaseAuth

class RegisterViewController: UIViewController {

    @IBOutlet weak var firstNameTExtFiled: UITextField!
    
    @IBOutlet weak var lastNameTextFiled: UITextField!
    @IBOutlet weak var EmailAddressTextFiled: UITextField!
    @IBOutlet weak var passwortTextFiled: UITextField!
    @IBAction func signUpBtn(_ sender: UIButton) {
        
        guard let email=EmailAddressTextFiled.text, !email.isEmpty,
              let password=passwortTextFiled.text, !password.isEmpty else{
                  print("line 23")

                  return
              }
        
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password, completion: { result,error in
           
            guard let theResult = result , error == nil else{
                print("line 31")

                return
            }
            
            print("bbbbbbb:\(result!.user)")
        })
        
        
        
    }
    @IBAction func goToSignInPage(_ sender: UIButton) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        passwortTextFiled.isSecureTextEntry=true
        
        
        
    }
    

   

}
