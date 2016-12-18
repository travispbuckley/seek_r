//
//  SendMessageViewController.swift
//  SEEK_R
//
//  Created by Apprentice on 12/18/16.
//  Copyright © 2016 dbcseekrgroup. All rights reserved.
//

import UIKit
class SendMessageViewController: ViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBOutlet weak var receiverName: UITextField!
    @IBOutlet weak var messageBody: UITextField!

    @IBAction func sendMessage(_ sender: UIButton) {
        
        let postString = "message%5Breceiver%5D=\(receiverName.text!)&message%5Bbody%5D=\(messageBody.text!)"
        httpRequest("http://localhost:3000/messages","POST",postString)
    }
}
