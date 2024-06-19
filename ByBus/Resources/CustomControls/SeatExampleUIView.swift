//
//  SeatExampleUIView.swift
//  ByBus
//
//  Created by Güray Gül on 28.04.2024.
//

import UIKit

class SeatExampleUIView: UIView {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 10
        layer.borderColor = UIColor.systemGray.cgColor
        layer.borderWidth = 0.3
        
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 8
        layer.shadowOffset = CGSize.zero
        layer.shadowColor = UIColor.systemBlue.cgColor
    }
}
