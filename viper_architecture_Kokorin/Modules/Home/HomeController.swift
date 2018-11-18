//
//  HomeController.swift
//  viper_architecture_Kokorin
//
//  Created by Alexander Kolovatov on 28/10/2018.
//  Copyright © 2018 Alexander Kolovatov. All rights reserved.
//

import UIKit

class HomeController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func handleLogout(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func handleDeleteUser(_ sender: UIButton) {
        print("Delete user")
    }
    

}
