//
//  Date+CoreDataProperties.swift
//  ByBus
//
//  Created by Güray Gül on 27.04.2024.
//
//

import Foundation
import CoreData


extension Date {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Date> {
        return NSFetchRequest<Date>(entityName: "Date")
    }

    @NSManaged public var date: String?
    @NSManaged public var ticket: Ticket?

}

extension Date : Identifiable {

}
