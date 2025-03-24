//
//  UIComponents.swift
//  Car_Rental_App
//
//  Created by David on 2/20/25.
//

import Foundation
import UIKit

class CustomTextField: UITextField {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.height / 2
        self.backgroundColor = .white
        self.layer.borderWidth = 0.2
        self.layer.borderColor = UIColor.black.cgColor
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 20, dy: 0)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 20, dy: 0)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 20, dy: 0)
    }
}
