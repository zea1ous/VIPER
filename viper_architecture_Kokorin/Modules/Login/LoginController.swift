//
//  LoginController.swift
//  viper_architecture_Kokorin
//
//  Created by Alexander Kolovatov on 28/10/2018.
//  Copyright © 2018 Alexander Kolovatov. All rights reserved.
//

import UIKit

class LoginController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func handleLogin(_ sender: UIButton) {
        guard let name = nameTextField.text else {
            print("Name field is empty")
            return
        }
        
        guard let password = passwordTextField.text else {
            print("Password field is empty")
            return
        }
        
        guard let user = UserStorage.getUserWith(name: name, password: password) else {
            print("User with this name is not exist")
            return
        }
        print(user.name)
        print(user.password!)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
