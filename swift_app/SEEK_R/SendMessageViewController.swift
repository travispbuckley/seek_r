//
//  SendMessageViewController.swift
//  SEEK_R
//
//  Created by Apprentice on 12/18/16.
//  Copyright © 2016 dbcseekrgroup. All rights reserved.
//

import UIKit
import MapKit
import BigInt
class SendMessageViewController: ViewController {
    var userKeyN = BigUInt(0)
    var userKeyE = BigUInt(0)
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


        EncryptionController.sendEncryptedMessage(receiverName.text!,messageBody.text!,locationCoords.text!)
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
