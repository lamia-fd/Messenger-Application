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
        let password=passwortTextFiled.text, !password.isEmpty,
        let firstNane=firstNameTExtFiled.text, !firstNane.isEmpty,
        let lastName=lastNameTextFiled.text, !lastName.isEmpty else{
                  print("the email or password is empty")

                  return
              }
        DatabaseManger.shared.validatUser(with: email, completion: {exists in
            guard !exists else{
                let alert = UIAlertController(title: "the account is already exist", message: "you can't use this account to register because the account is already exist", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "ok", style: .cancel, handler: {_ in}))
                return
            }
            
            
        })
        
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password, completion:{ result,error in
           
            guard let theResult = result , error == nil else{
                print("error in logging in :\(String(describing: error?.localizedDescription))")

                return
            }
            
            print("you are loging in:\(theResult.user)")
            
            DatabaseManger.shared.insertUser(with: DatabaseManger.chatAppUser(firstName:firstNane
                                                               ,lastName:lastName
                                                               ,emailAdderss:email))
            
            
            let signedIn=self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
            self.navigationController?.pushViewController(signedIn, animated: true)
        })
        
    }
    @IBAction func goToSignInPage(_ sender: UIButton) {
        
    let signedIn=self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
    self.navigationController?.pushViewController(signedIn, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwortTextFiled.isSecureTextEntry=true
    }
    
}
