//
//  Privatekey+CoreDataProperties.swift
//  
//
//  Created by Apprentice on 12/21/16.
//
//

import Foundation
import CoreData


extension Privatekey {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Privatekey> {
        return NSFetchRequest<Privatekey>(entityName: "Privatekey");
    }

    @NSManaged public var private_key_d: String?
    @NSManaged public var private_key_n: String?

    @NSManaged public var username: String?

}
