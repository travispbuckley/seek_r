//
//  ConversationDetailViewController.swift
//  SEEK_R
//
//  Created by Apprentice on 12/19/16.
//  Copyright © 2016 dbcseekrgroup. All rights reserved.
//

import UIKit

class ConversationDetailViewController: UIViewController {
    
    @IBOutlet weak var messageWindow: UILabel!
    
    var webSite: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        messageWindow.text = ""
        if let address = webSite {
            print(address)
            DispatchQueue.main.async(execute: {
                self.requestMessages("http://localhost:3000/messages/" + address)
            })
            
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func requestMessages(_ url: String){
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        let session = URLSession.shared
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

                if let messages = data_block["messages"] as? NSArray
                {
                    print("ITs and array")
                    
                    self.messageWindow.text = "\(messages[0])\n\(messages[1])\n\(messages[2])"
                

                    //print(data_block[messages])
                    //self.messages.text = messages as! [String]
                    //print(messages)
                    //self.messagesField.text = self.messages["0"]
                }
                
            }
            
            
            
        })
        
        task.resume()
        
        
    }


}
