//
//  ViewController.swift
//  SEEK_R
//
//  Created by Apprentice on 12/16/16.
//  Copyright © 2016 dbcseekrgroup. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var usernameField: UITextField!

    @IBOutlet weak var password: UITextField!
    
    
    
    @IBAction func loginButton(_ sender: UIButton) {
        let postString = "user%5Busername%5D=\(usernameField.text!)&user%5Bpassword%5D=\(password.text!)"
        httpRequest("http://localhost:3000/sessions","POST",postString)
    }

    
    func httpRequest(_ url: String, _ method:String,_ postString:String) {
        var successfulLogin = false // will be used to login later
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = method
        let session = URLSession.shared
        //let postString = "name=\(usernameField.text!)&password=\(password.text!)"
        //let postString = "user%5Busername%5D=\(usernameField.text!)&user%5Bpassword%5D=\(password.text!)"
        request.httpBody = postString.data(using: .utf8)
        let task = session.dataTask(with: request as URLRequest, completionHandler: {
            (
            data, response, error) in
            guard let _:Data = data, let _:URLResponse = response  , error == nil else {
                return
            }
            let json: Any?
            do
            {
                json = try JSONSerialization.jsonObject(with: data!, options: [])
                print(json ?? "there is no json")
            }
            catch
            {
                return
            }
            guard let server_response = json as? NSDictionary else
            {
                return
            }
            
            // login with session and save it:
            if let data_block = server_response["data"] as? NSDictionary
            {
                if let session_data = data_block["session"] as? String
                {
                    let preferences = UserDefaults.standard
                    preferences.set(session_data, forKey: "session")
                    successfulLogin = true
                    print("LOGGED")
                }
                
                // if there is a set session data, then segue into the next page.. or not:
                if successfulLogin == true {
                    print("SUCCCESFUL")
                    
                    
                    // THIS TAKES FOREVER
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "SendMessageSegue", sender: self)
                    }
                    ///

      
                    
                } else {
                    print("bad user")
                    
                }
            }
        })
        task.resume() // this line placement is important for waiting
    } //end-func
    
} // end-class

