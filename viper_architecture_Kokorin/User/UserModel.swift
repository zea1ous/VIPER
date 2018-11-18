//
//  User.swift
//  viper_architecture_Kokorin
//
//  Created by Alexander Kolovatov on 28/10/2018.
//  Copyright © 2018 Alexander Kolovatov. All rights reserved.
//

import Foundation

class UserModel {
    
    var inputDict: [String: Any] = [:]
    
    var name: String {
        set(newName) {
            inputDict["name"] = newName
        }
        
        get {
            return inputDict["name"] as? String ?? ""
        }
    }
    
    var password: String {
        set(newPass) {
            inputDict["password"] = newPass
        }
        
        get {
            return inputDict["password"] as? String ?? ""
        }
    }
    
    convenience init(inputDict: [String: Any]) {
        self.init()
        self.inputDict = inputDict
    }
    
}
