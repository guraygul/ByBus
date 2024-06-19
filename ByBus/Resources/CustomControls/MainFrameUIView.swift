//
//  MainFrameUIView.swift
//  ByBus
//
//  Created by Güray Gül on 25.04.2024.
//

import UIKit

class MainFrameUIView: UIView {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 20
        layer.shadowOffset = CGSize.zero
        layer.shadowColor = UIColor.systemBlue.cgColor
        layer.cornerRadius = 10
    }
}
