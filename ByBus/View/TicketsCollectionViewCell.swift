//
//  TicketsCollectionViewCell.swift
//  ByBus
//
//  Created by Güray Gül on 27.04.2024.
//

import UIKit

class TicketsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var ticketNameSurname: UILabel!
    @IBOutlet weak var ticketID: UILabel!
    @IBOutlet weak var ticketDate: UILabel!
    @IBOutlet weak var ticketHour: UILabel!
    @IBOutlet weak var fromLocation: UILabel!
    @IBOutlet weak var toLocation: UILabel!
    @IBOutlet weak var ticketSeat: UILabel!
    @IBOutlet weak var ticketPrice: UILabel!
    @IBOutlet weak var ticketEstHour: UILabel!
    @IBOutlet weak var ticketBusFirm: UILabel!
}
