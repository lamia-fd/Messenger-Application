//
//  DatabaseManger.swift
//  Messenger Application
//
//  Created by لمياء فالح الدوسري on 01/06/1443 AH.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage
import SwiftUI


final class DatabaseManger {
    
    static let shared = DatabaseManger()
    private let database = Database.database().reference()
    
    
    func validatUser(with email : String , completion: @escaping ((Bool)->Void)){
        var saveEmail = email.replacingOccurrences(of: ".", with: "-")
        saveEmail = saveEmail.replacingOccurrences(of: "@", with: "-")
        database.child(saveEmail).observeSingleEvent(of: .value, with: { snapshot in
            guard let fonedEmail = snapshot.value as? String else {
                completion(false)
                return
            }
            completion(true)
        })
        
        
    }
    
    func insertUser(with user: chatAppUser){
        database.child(user.saveEmail).setValue([
            "first_name":user.firstName,
            "last_name":user.lastName
        ])
        
    }
    
    struct chatAppUser{
        let firstName:String
        let lastName:String
        let emailAdderss:String
        //let profilePic:String
        
        
        var saveEmail:String{
            var saveEmail = emailAdderss.replacingOccurrences(of: ".", with: "-")
            saveEmail = saveEmail.replacingOccurrences(of: "@", with: "-")
            return saveEmail
        }
    }
    
}
