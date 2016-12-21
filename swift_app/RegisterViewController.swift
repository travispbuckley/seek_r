//
//  RegisterViewController.swift
//  SEEK_R
//
//  Created by Apprentice on 12/16/16.
//  Copyright © 2016 dbcseekrgroup. All rights reserved.
//

import UIKit

class RegisterViewController: ViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = false;        // may cause back button issues later on.


    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    @IBAction func createUser(_ sender: UIButton) {
        let postString = "user%5Busername%5D=\(usernameField.text!)&user%5Bpassword%5D=\(password.text!)"
        httpRequest("http://localhost:3000/users","POST",postString)
    }
  }
