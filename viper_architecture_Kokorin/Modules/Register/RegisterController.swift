//
//  RegisterController.swift
//  viper_architecture_Kokorin
//
//  Created by Alexander Kolovatov on 28/10/2018.
//  Copyright © 2018 Alexander Kolovatov. All rights reserved.
//

import UIKit

class RegisterController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func handleRegister(_ sender: UIButton) {
        guard let name = nameTextField.text else { return }
        guard let password = passwordTextField.text else { return }
//        guard let email = emailTextField.text else { return }
        
        var dict = [String: Any]()
        dict["name"] = name
//        dict["email"] = email
        dict["password"] = password
        
        let userModel = UserModel(inputDict: dict)
        
        UserStorage.createUser(userModel: userModel)
        
        dismiss(animated: true, completion: nil)
    }
}
