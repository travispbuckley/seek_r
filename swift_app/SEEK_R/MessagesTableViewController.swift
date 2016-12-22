//
//  MessagesTableViewController.swift
//  SEEK_R
//
//  Created by Apprentice on 12/18/16.
//  Copyright © 2016 dbcseekrgroup. All rights reserved.
//

import UIKit

class MessagesTableViewController: UITableViewController {
    var convoNames = [String: String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestConversations("http://localhost:3000/messages")
//        requestConversations("https://seekr-backend.herokuapp.com/messages")
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        //print(convoNames.count)
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return convoNames.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath)
        
        cell.textLabel?.text = "\(convoNames[String(indexPath.row)]!)"
        cell.textLabel?.textColor = UIColor.white

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        
        if segue.identifier == "ShowAttractionDetails" {
             print("debug: prepare executed in MessagesTableViewController")
            let detailViewController = segue.destination
                as! ConversationDetailViewController
            
            let myIndexPath = self.tableView.indexPathForSelectedRow!
            detailViewController.webSite = convoNames[String(myIndexPath.row)]!
        }
    }
    
    func requestConversations(_ url: String){
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
                if let conversations = data_block["conversations"] as? NSDictionary
                {
                    self.convoNames = conversations as! [String : String]
                    print(self.convoNames)
                    self.tableView.reloadData()
                }

            }
            
            
            
        })
        
        task.resume()
        

    }
    
    @IBAction func logOut(_ sender: UIBarButtonItem) {
        let preferences = UserDefaults.standard
        preferences.set(nil, forKey: "session")
        
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "LogoutButtonSegue", sender: self)
        }
    }
    
    
    
    
    
    
    
    
    /*
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Section \(section)"
    }
    */
}
