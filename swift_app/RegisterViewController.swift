//
//  RegisterViewController.swift
//  SEEK_R
//
//  Created by Apprentice on 12/16/16.
//  Copyright © 2016 dbcseekrgroup. All rights reserved.
//

import UIKit
import BigInt
import CoreData
class RegisterViewController: ViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = false;        // may cause back button issues later on.


    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    @IBAction func createUser(_ sender: UIButton) {
        print("start")
  
        
        let keyArr = EncryptionController.generateKey()
        let n: String = keyArr[0] as! String
        let e = keyArr[1]
        let d: String = keyArr[2] as! String
        //let stringN: String = keyArr[0] as! String
        let newPrivateKey = NSEntityDescription.insertNewObject(forEntityName: "Privatekey", into: DatabaseController.getContext()) as! Privatekey
        
        newPrivateKey.private_key_d = d
        newPrivateKey.private_key_n = n
        print("D")
        print(d)
        print("N")
        print(n)
        newPrivateKey.username = usernameField.text!
        DatabaseController.saveContext()
        let postString = "user%5Busername%5D=\(usernameField.text!)&user%5Bpassword%5D=\(password.text!)&user%5Bpublic_key_n%5D=\(n)&user%5Bpublic_key_e%5D=\(e)"
        httpRequest("http://localhost:3000/users","POST",postString)
    }
  }
