//
//  RegisterViewController.swift
//  SEEK_R
//
//  Created by Apprentice on 12/16/16.
//  Copyright © 2016 dbcseekrgroup. All rights reserved.
//

import UIKit
import BigInt
class RegisterViewController: ViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    @IBAction func createUser(_ sender: UIButton) {
        print("start")
        typealias Key = (modulus: BigUInt, exponent: BigUInt)
        let harKeyPub = ("39488476440523645748859986663072392692401837183296467549839373313950857795979369389328764314380776716228144468014805574293833587935458695495232435699770315723544627243044298169558406392841464870244731363", "65537") as Key
        let harKeyPrivate = ("39488476440523645748859986663072392692401837183296467549839373313950857795979369389328764314380776716228144468014805574293833587935458695495232435699770315723544627243044298169558406392841464870244731363", "28369256088151346762799254650921425532696884204360095543724723648332212911913829576540980060332180449370287721768618140139224600902763516320412661993226843898050710432211803322544125537360962828389651993") as Key
        
        func encrypt(_ message: BigUInt, key: Key) -> BigUInt {
            return message.power(key.exponent, modulus: key.modulus)
        }
        
        let secret: BigUInt = BigUInt("This Message was decrypted *&^$#@!".data(using: String.Encoding.utf8)!)
        let cyphertext = encrypt(secret, key: harKeyPub)
        let plaintext = encrypt(cyphertext, key: harKeyPrivate)
        let received = String(data: plaintext.serialize(), encoding: String.Encoding.utf8)
        print(received!)
        func generatePrime(_ width: Int) -> BigUInt {
            while true {
                var random = BigUInt.randomInteger(withExactWidth: width)
                random |= BigUInt(1)
                if random.isPrime() {
                    return random
                }
            }
        }
        let p = generatePrime(100)
        let q = generatePrime(100)
        let n = p * q

        let e: BigUInt = 65537
        let phi = (p - 1) * (q - 1)
        let d = e.inverse(phi)!
        let publicKey: Key = (n, e)
        let privateKey: Key = (n, d)
        print(publicKey)
        print(privateKey)
        
        let postString = "user%5Busername%5D=\(usernameField.text!)&user%5Bpassword%5D=\(password.text!)&user%5Bpublic_key%5D=\(publicKey)"
        httpRequest("http://localhost:3000/users","POST",postString)
    }
  }
