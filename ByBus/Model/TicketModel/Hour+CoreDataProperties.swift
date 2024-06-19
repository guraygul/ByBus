//
//  Hour+CoreDataProperties.swift
//  ByBus
//
//  Created by Güray Gül on 28.04.2024.
//
//

import Foundation
import CoreData


extension Hour {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Hour> {
        return NSFetchRequest<Hour>(entityName: "Hour")
    }

    @NSManaged public var hour: String?
    @NSManaged public var estHour: String?
    @NSManaged public var ticket: Ticket?

}

extension Hour : Identifiable {

}
