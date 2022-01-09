//
//  ViewController.swift
//  Messenger Application
//
//  Created by لمياء فالح الدوسري on 26/05/1443 AH.
//

import UIKit
import Firebase
import FirebaseAuth
import FBSDKLoginKit


class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextFiled: UITextField!
    @IBOutlet weak var passwordTextFiled: UITextField!
    @IBAction func signinBtn(_ sender: UIButton) {
       
    
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
            
            strongSelf.passwordTextFiled.text=""
            
            let signedIn=self?.storyboard?.instantiateViewController(withIdentifier: "cv")
            self?.navigationController?.pushViewController(signedIn!, animated: true)
            
            
        })
      
       
    }
   @IBAction func signInWithFaceBook(_ sender: FBLoginButton)// -> FBLoginButton
    {
//        let button = FBLoginButton()
//        button.permissions = ["email, public_profile"]
//
//        return button
//        let signedIn=self.storyboard?.instantiateViewController(withIdentifier: "cv")
//        navigationController?.pushViewController(signedIn!, animated: true)

    }
    
    func showAlartAcounNotExest(){
        let alert = UIAlertController(title: "Your account was not found", message: "Your account was not found. Please create a new account", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok", style: .cancel, handler: {_ in}))
    }
    
    
    @IBAction func goToSignUpPage(_ sender: UIButton) {
        
        
        let signedIn=self.storyboard?.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
        self.navigationController?.pushViewController(signedIn, animated: true)
        
        
        
    }
    private let facebookloginButton:FBLoginButton = {
        let button = FBLoginButton()
               button.permissions = ["public_profile", "email"]
       
               return button
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        passwordTextFiled!.isSecureTextEntry=true
        facebookloginButton.center = view.center
                view.addSubview(facebookloginButton)
        facebookloginButton.delegate = self
        
//        if FirebaseAuth.Auth.auth().currentUser != nil {
//
//            print("you are signed in ")
//            do{
//           try FirebaseAuth.Auth.auth().signOut()
//            }catch{
//               print("error in signing out")
//            }
//            let signedIn=self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
//            navigationController?.pushViewController(signedIn, animated: true)
//
//
//        }

       // createUser(name: "lamia", age: 55)
        
        facebookloginButton.center = view.center
        facebookloginButton.frame = CGRect(x:55, y:passwordTextFiled.frame.minY-70, width:320, height:31)
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

extension LoginViewController:LoginButtonDelegate{
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        guard let token = result?.token?.tokenString else {
            print("User Failed to log in with facbook")
            return
        }
      //  let token = result?.token?.tokenString
        let request = FBSDKLoginKit.GraphRequest(graphPath: "me", parameters: ["fields" : "email, name"],
  tokenString: token, version: nil, httpMethod: .get)
        request.start(completionHandler: {connection, result,error in
            guard let result = result as? [String:Any], error == nil else {
                print("Failed to make path requst facbook")

                return
            }

            print("\(result)")
            guard let userName = result["name"] as? String,
                  let email = result["email"] as? String else{
                      print("Failed to get email and name")

                      return
                  }
            let componantName=userName.components(separatedBy: " ")
            guard componantName.count == 2 else{
                return
            }
            let firstName = componantName[0]
            let lastName = componantName[1]
            DatabaseManger.shared.validatUser(with: email, completion: {exists in
                if !exists {
                    DatabaseManger.shared.insertUser(with: DatabaseManger.chatAppUser(firstName:firstName
                                                        ,lastName:lastName
                                                        ,emailAdderss:email))
                }
            })
            
            let credential = FacebookAuthProvider.credential(withAccessToken: token)

            FirebaseAuth.Auth.auth().signIn(with: credential, completion: {[weak self] AuthResult, error in
                guard let strongself = self else{
                    return
                }
                
                guard AuthResult != nil , error == nil else{
                    print("User Failed to log in with facbook credential")

                    return
                }
                print("successfully")
               let signedIn=strongself.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
                strongself.navigationController?.pushViewController(signedIn, animated: true)


            })
        })
       
    }

    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        
    }


}

