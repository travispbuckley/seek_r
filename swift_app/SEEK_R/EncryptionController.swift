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
    
    class func encrypt(_ messageBody: String,_ keyN: BigUInt,_ keyEOrD: BigUInt) -> BigUInt {
        typealias Key = (modulus: BigUInt, exponent: BigUInt)
        let key = (keyN,keyEOrD)
        
        func encrypt(_ message: BigUInt, key: Key) -> BigUInt {
            return message.power(key.exponent, modulus: key.modulus)
        } 
        let secret: BigUInt = BigUInt(messageBody.data(using: String.Encoding.utf8)!)
        let cyphertext = encrypt(secret, key: key)
        
        return cyphertext
    }
    
    class func decrypt(_ messageBody: BigUInt,_ privateKeyN: BigUInt,_ privateKeyD: BigUInt) -> String {
        typealias Key = (modulus: BigUInt, exponent: BigUInt)
        let privateKey = (privateKeyN,privateKeyD)
        
        func encrypt(_ message: BigUInt, key: Key) -> BigUInt {
            return message.power(key.exponent, modulus: key.modulus)
        }
        let plaintext = encrypt(messageBody, key: privateKey)
        let received = String(data: plaintext.serialize(), encoding: String.Encoding.utf8)
        print(received!)
        return received!
    }
    
}
