//
//  Ticket+CoreDataProperties.swift
//  ByBus
//
//  Created by Güray Gül on 29.04.2024.
//
//

import Foundation
import CoreData


extension Ticket {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Ticket> {
        return NSFetchRequest<Ticket>(entityName: "Ticket")
    }

    @NSManaged public var busFirmImage: String?
    @NSManaged public var fromLocation: String?
    @NSManaged public var seatNo: String?
    @NSManaged public var ticketID: UUID?
    @NSManaged public var ticketPrice: String?
    @NSManaged public var toLocation: String?
    @NSManaged public var busFirm: String?
    @NSManaged public var customer: Person?
    @NSManaged public var ticketDate: Date?
    @NSManaged public var ticketHour: Hour?

}

extension Ticket : Identifiable {

}
