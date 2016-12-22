//
//  EncryptionController.swift
//  SEEK_R
//
//  Created by Apprentice on 12/21/16.
//  Copyright © 2016 dbcseekrgroup. All rights reserved.
//

import Foundation
import BigInt
class EncryptionController{
    
    class func encryptMessage(_ messageBody: String,_ keyN: BigUInt,_ keyEOrD: BigUInt) -> BigUInt {
        typealias Key = (modulus: BigUInt, exponent: BigUInt)
        let key = (keyN,keyEOrD)
        
        func encrypt(_ message: BigUInt, key: Key) -> BigUInt {
            return message.power(key.exponent, modulus: key.modulus)
        } 
        let secret: BigUInt = BigUInt(messageBody.data(using: String.Encoding.utf8)!)
        print("Secret")
        print(secret)
        let cyphertext = encrypt(secret, key: key)
        
        return cyphertext
    }
    
    class func decryptMessage(_ messageBody: BigUInt,_ privateKeyN: BigUInt,_ privateKeyD: BigUInt) -> String {
        typealias Key = (modulus: BigUInt, exponent: BigUInt)
        let privateKey = (privateKeyN,privateKeyD)
        print(messageBody)
        print("----------------")
        print(privateKeyN)
        print("--n--------------")

        print(privateKeyD)
        print("---d-------------")

        func encrypt(_ message: BigUInt, key: Key) -> BigUInt {
            return message.power(key.exponent, modulus: key.modulus)
        }
        
        let plaintext = encrypt(messageBody, key: privateKey)
        print(privateKey)
        
        //good
        print(plaintext)
        let received = String(data: plaintext.serialize(), encoding: String.Encoding.utf8)
        print(received)
        if (received == nil){
            return "HERE IS A BUG IN DECRYPT"
        }else{
            return received!
        }
    }
    
    class func generateKey() -> NSArray{
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
        let n = String(p * q)
        let e: BigUInt = 65537
        let E = String(e)
        let phi = (p - 1) * (q - 1)
        let d = String(e.inverse(phi)!)
//        let publicKey: Key = (n, e)
//        let privateKey: Key = (n, d)
        return [n,E,d]
    }
    
    class  func sendEncryptedMessage(_ username: String,_ message: String,_ locationCoords: String) {
        let urlString = "https://seekr-backend.herokuapp.com/users/" + username
        var request = URLRequest(url: URL(string: urlString)!)
        request.httpMethod = "GET"
        let session = URLSession.shared
        let postString = ""
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
            if let publicKey = server_response["user"] as? NSDictionary
            {

                let publicKeyN = publicKey["n"] as! String
                let bigintN = BigUInt(publicKeyN)
                let publicKeyE = publicKey["e"] as! String
                let bigintE = BigUInt(publicKeyE)
                
                let yourPublicKeyN = publicKey["your_n"] as! String
                let yourBigintN = BigUInt(yourPublicKeyN)
                let yourPublicKeyE = publicKey["your_e"] as! String
                let yourBigintE = BigUInt(yourPublicKeyE)
                
                
                let encryptedMessage = String(EncryptionController.encryptMessage(message, bigintN!, bigintE!))
                let yourEncryptedMessage = String(EncryptionController.encryptMessage(message, yourBigintN!, yourBigintE!))
                let url = "https://seekr-backend.herokuapp.com/messages"
                var request = URLRequest(url: URL(string: url)!)
                request.httpMethod = "POST"
                let session = URLSession.shared
                let postString2 = "message%5Breceiver%5D=\(username)&message%5Bbody%5D=\(encryptedMessage)&message%5Byour_message%5D=\(yourEncryptedMessage)&message%5Blocation%5D=\(locationCoords)"
                request.httpBody = postString2.data(using: .utf8)
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
                    
                })
            task.resume()
            }
        })
        task.resume() // this line placement is important for waiting
    } //end-func

}
