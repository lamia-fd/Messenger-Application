//
//  ProfileViewController.swift
//  Messenger Application
//
//  Created by لمياء فالح الدوسري on 28/05/1443 AH.
//

import UIKit
import FirebaseAuth
import FBSDKLoginKit

class ProfileViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    let data=["log out"]

    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        
    }
    

   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text=data[indexPath.row]
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.textColor = .red
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let alert=UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: {[weak self] _ in
            guard let strongSelf = self else{
                return
            }
            
            FBSDKLoginKit.LoginManager().logOut()
            do{
                try FirebaseAuth.Auth.auth().signOut()
                
                
            let signedIn=strongSelf.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                strongSelf.navigationController?.pushViewController(signedIn, animated: true)
                
            }catch{
                print("error in logign out ")
            }
            
            
            
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true)
        
        
    }
}
 
