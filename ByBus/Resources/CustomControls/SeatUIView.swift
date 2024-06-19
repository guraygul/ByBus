//
//  SeatUIView.swift
//  ByBus
//
//  Created by Güray Gül on 27.04.2024.
//

import UIKit

class SeatUIView: UIView {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupGestureRecognizer()
        
        layer.cornerRadius = 10
        layer.borderColor = UIColor.systemGray.cgColor
        layer.borderWidth = 0.3
        
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 8
        layer.shadowOffset = CGSize.zero
        layer.shadowColor = UIColor.systemBlue.cgColor
    }
    
    var isSelected = false {
        didSet {
            updateAppearance()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGestureRecognizer()
    }
    
    private func setupGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        addGestureRecognizer(tapGesture)
    }
    
    @objc private func handleTap(_ gesture: UITapGestureRecognizer) {
        isSelected = !isSelected
    }
    
    private func updateAppearance() {
        backgroundColor = isSelected ? Theme.accent : Theme.backgroundColor
        if let label = subviews.first as? UILabel {
            label.textColor = isSelected ? UIColor.white : Theme.accent
        }
    }
}
