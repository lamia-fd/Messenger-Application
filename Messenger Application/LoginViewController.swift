//
//  ViewController.swift
//  Messenger Application
//
//  Created by لمياء فالح الدوسري on 26/05/1443 AH.
//

import UIKit
import Firebase
import FirebaseAuth


class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextFiled: UITextField!
    @IBOutlet weak var passwordTextFiled: UITextField!
    @IBAction func signinBtn(_ sender: UIButton) {
       
        let signedIn=self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        navigationController?.pushViewController(signedIn, animated: true)
    }
    @IBAction func signInWithFaceBook(_ sender: UIButton) {
        guard let email=emailTextFiled.text, !email.isEmpty,
              let password=passwordTextFiled.text, !password.isEmpty else{
                  print("line22")
                  return
              }
        
        print(email)
        print(password)
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password, completion: {[weak self] result,error in
            guard let strongSelf = self else{
                print("line30")
                return
            }
            guard error == nil else{
                strongSelf.showAlartAcounNotExest()
                print("line35")


                
                return
            }
            
            print("bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb")
            let signedIn=self?.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
            self?.navigationController?.pushViewController(signedIn, animated: true)
            
            
        })
      
        
        
        
    }
    
    func showAlartAcounNotExest(){
        let alert = UIAlertController(title: "Your account was not found", message: "Your account was not found. Please create a new account", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok", style: .cancel, handler: {_ in}))
    }
    
    
    @IBAction func goToSignUpPage(_ sender: UIButton) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        passwordTextFiled.isSecureTextEntry=true
        
        if FirebaseAuth.Auth.auth().currentUser != nil {
            
            print("hiiiihhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhii")
            do{
           try FirebaseAuth.Auth.auth().signOut()
            }catch{
               print("hihihihihihihihihihihihihihi br")
            }
            let signedIn=self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
            navigationController?.pushViewController(signedIn, animated: true)
            
            
        }

       // createUser(name: "lamia", age: 55)
        
        
           }
           
           func createUser(name:String, age:Int) {
               var user1:[String:Any] = ["name":name]
               let userID = UUID().uuidString
               user1["age"] = age
               
               //1. Create Database reference
               var ref: DatabaseReference!
               ref = Database.database().reference()
               //ref.child("users").setValue(userDict) // dont do this
               
               //2. Get the user object from firebase database
               ref.child("users").observeSingleEvent(of: .value) { snapshot in
                   print("snapshot Value: \(snapshot.value!)")
                   
                   if var allUserDict = snapshot.value as? [String:Any] { // important
                       print("database has values, updating the user")
                       
                       // 3. Update the user dictionary with new user object
                       allUserDict[userID] = user1
                       
                       //4. Send the dictionary to firebase
                       ref.child("users").updateChildValues([userID:user1])
                   } else {
                       print("Empty databse, set the user")
                       let allUserDict = [userID:user1]
                       // Database is empty
                       ref.child("users").setValue(allUserDict)
                   }
                   
                   
                   
               }
               
           }


}

