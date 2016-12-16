//
//  ViewController.swift
//  SEEK_R
//
//  Created by Apprentice on 12/16/16.
//  Copyright © 2016 dbcseekrgroup. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    

    @IBAction func postUsers(_ sender: Any) {
        var request = URLRequest(url: URL(string: "http://localhost:3000/users")!)
        request.httpMethod = "POST"
        let postString = "name=eraince&password=pass"
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString)")
        }
        task.resume()
        
    }
    
    
}

