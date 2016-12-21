//
//  SendMessageViewController.swift
//  SEEK_R
//
//  Created by Apprentice on 12/18/16.
//  Copyright © 2016 dbcseekrgroup. All rights reserved.
//

import UIKit
import MapKit

class SendMessageViewController: ViewController {
    
    var locManager = CLLocationManager()
    var currentLocation: CLLocation! // this holds our coords

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = false;        // may cause back button issues later on.

        
        // requests user auth for GPS:
        locManager.requestWhenInUseAuthorization()
        
        // this checks if user authorized on GPS:
        if (CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways){
            currentLocation = locManager.location
            print(currentLocation.coordinate.latitude)
            print(currentLocation.coordinate.longitude)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MESSAGE INPUT //
    @IBOutlet weak var receiverName: UITextField!
    @IBOutlet weak var messageBody: UITextField!
    @IBOutlet weak var locationCoords: UITextField!

    @IBAction func sendMessage(_ sender: UIButton) {
        
        let postString = "message%5Breceiver%5D=\(receiverName.text!)&message%5Bbody%5D=\(messageBody.text!)&message%5Blocation%5D=\(locationCoords.text!)"
        httpRequest("http://localhost:3000/messages/","POST",postString)
    }
    
    
    // GPS COORD: //
    @IBAction func getCoords(_ sender: Any) {
        let latitude = currentLocation.coordinate.latitude
        let longitude = currentLocation.coordinate.longitude
        
        locationCoords.text! = "\(latitude), \(longitude)"
            print("GET COORDS BUTTON HIT!")
    }    
}
// note: the app wont work properly until they restart after accepting. throws an error/crash
