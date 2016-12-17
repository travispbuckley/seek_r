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

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    @IBAction func createUser(_ sender: UIButton) {
        postRequest("http://localhost:3000/users")
    }
  }
