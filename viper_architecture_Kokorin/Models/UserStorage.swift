//
//  CoreDataEngine.swift
//  viper_architecture_Kokorin
//
//  Created by Alexander Kolovatov on 28/10/2018.
//  Copyright © 2018 Alexander Kolovatov. All rights reserved.
//

import Foundation
import CoreData

class UserStorage {
    
    class func createUser(userModel: UserModel) {
        StorageService.shared.dataStack.performInNewBackgroundContext { (context) in
            guard let user = NSEntityDescription.insertNewObject(forEntityName: "User", into: context) as? User else { return }
            
            user.name = userModel.name
            user.password = userModel.password

            do {
                try context.save()
                print("User has been saved succesfully")
                
            } catch {
                print(error.localizedDescription)
            }
            
        }
    }
    
    class func getUser() -> User {
        let context = StorageService.shared.dataStack.viewContext
        let request = NSFetchRequest<User>(entityName: NSStringFromClass(User.self))
        var user: User!
        
        do {
            let results = try context.fetch(request)
            
            if let fetchedUser = results.first {
                user = fetchedUser
            }
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        return user
    }
    
    class func clearData() {
        let context = StorageService.shared.dataStack.viewContext
        let request = NSFetchRequest<User>(entityName: NSStringFromClass(User.self))
        
        do {
            let results = try context.fetch(request)
            
            results.forEach { (userData) in
                context.delete(userData)
            }
            
            try context.save()
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
//    func checkUserExist() -> Bool {
//        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
//
//        do {
//            let result = try context.execute(request)
//
//            print("Data got 0 values", result)
//            return true
//        } catch let error {
//            print("Could not get user info", error.localizedDescription)
//            return false
//        }
//    }
//
//    func loginUser(user: UserModel) -> Bool {
//        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
//        request.predicate = NSPredicate(format: "%K==%@", "name", user.name)
//
//        do {
//            let result = try context.execute(request)
//            print("Data got 0 values")
//            return true
//        } catch let error {
//            print("Could not get user info", error.localizedDescription)
//            return false
//        }
//    }
//
//    func deleteUser() {
//        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
//
//        do {
//            let result = try context.execute(request)
//            print("Data got 0 values")
//            result
//
//
//        } catch let error {
//            print("Could not get user info", error.localizedDescription)
//            return
//        }
//    }
    
}
