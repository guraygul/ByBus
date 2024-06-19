//
//  Person+CoreDataProperties.swift
//  ByBus
//
//  Created by Güray Gül on 27.04.2024.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var name: String?
    @NSManaged public var surname: String?
    @NSManaged public var id: String?
    @NSManaged public var ticket: Ticket?

}

extension Person : Identifiable {

}
