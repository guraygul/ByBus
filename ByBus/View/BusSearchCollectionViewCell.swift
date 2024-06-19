//
//  BusSearchCollectionViewCell.swift
//  ByBus
//
//  Created by Güray Gül on 25.04.2024.
//

import UIKit

class BusSearchCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var busImage: UIImageView!
    @IBOutlet weak var busTime: UILabel!
    @IBOutlet weak var busPrice: UILabel!
    
    @IBOutlet weak var estimatedTime: UILabel!
    @IBOutlet weak var seatsLeft: UILabel!
    @IBOutlet weak var fromLocation: UILabel!
    @IBOutlet weak var toLocation: UILabel!
}
