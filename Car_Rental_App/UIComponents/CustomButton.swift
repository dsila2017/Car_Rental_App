//
//  CustomButton.swift
//  Car_Rental_App
//
//  Created by User on 10.03.25.
//

import Foundation
import UIKit

final class CustomButton: UIButton {
    enum Style {
        case primary, secondary
        
        var textColor: UIColor {
            switch self {
            case .primary:
                return .white
            case .secondary:
                return .black
            }
        }
        
        var backgroundColor: UIColor {
            switch self {
            case .primary:
                return .black
            case .secondary:
                return .white
            }
        }
        
        var borderColor: UIColor {
            switch self {
            case .primary:
                return .white
            case .secondary:
                return .black
            }
        }
    }
    let name: String
    let style: Style
    
    init(name: String, style: Style) {
        self.name = name
        self.style = style
        super.init(frame: .zero)
        
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.height / 2
    }
    
    private func setupButton() {
        self.clipsToBounds = true
        self.layer.borderColor = style.borderColor.cgColor
        self.layer.borderWidth = 1
        
        self.configuration = .filled()
        var attributedTitle = AttributedString(name)
        attributedTitle.font = UIFont.boldSystemFont(ofSize: 17)
        
        self.configuration?.attributedTitle = attributedTitle
        self.configuration?.baseBackgroundColor = style.backgroundColor
        self.configuration?.baseForegroundColor = style.textColor
    }
}
