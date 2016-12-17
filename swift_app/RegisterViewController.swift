//
//  RegisterViewController.swift
//  SEEK_R
//
//  Created by Apprentice on 12/16/16.
//  Copyright © 2016 dbcseekrgroup. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBAction func createUser(_ sender: UIButton) {
        postRequest("http://localhost:3000/users")
    }
    func postRequest(_ url: String) {
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        let session = URLSession.shared
        //let postString = "name=\(usernameField.text!)&password=\(password.text!)"
        let postString = "user%5Busername%5D=\(usernameField.text!)&user%5Bpassword%5D=\(password.text!)"
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
            
            
            if let data_block = server_response["data"] as? NSDictionary
            {
                if let session_data = data_block["session"] as? String
                {
                    let preferences = UserDefaults.standard
                    preferences.set(session_data, forKey: "session")
                    
                }
            }
            
            
            
        })
        
        task.resume()
        
        
    }
}
