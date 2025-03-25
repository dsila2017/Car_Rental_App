//
//  ImageStack.swift
//  Car_Rental_App
//
//  Created by User on 24.03.25.
//

import Foundation
import UIKit

class ImageStackView: UIView {
    
    private let carImageView = UIImageView()
    private let brandLabel = UILabel()
    private let modelLabel = UILabel()
    private let priceLabel = UILabel()
    private let textStackView = UIStackView()
    private let mainStackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI(image: UIImage(), brand: "Brand", model: "Model", price: "0")
    }
    
    init(image: UIImage, brand: String, model: String, price: String) {
        super.init(frame: .zero)
        setupUI(image: image, brand: brand, model: model, price: price)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI(image: UIImage(), brand: "Brand", model: "Model", price: "0")
    }
    
    private func setupUI(image: UIImage, brand: String, model: String, price: String) {
        carImageView.image = image
        carImageView.contentMode = .scaleAspectFit
        carImageView.isAccessibilityElement = true
        carImageView.accessibilityLabel = "Car image"
        
        brandLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        brandLabel.adjustsFontForContentSizeCategory = true
        brandLabel.text = "Brand: \(brand)"
        brandLabel.numberOfLines = 1
        brandLabel.isAccessibilityElement = true
        brandLabel.accessibilityLabel = "Brand: \(brand)"
        
        modelLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        modelLabel.adjustsFontForContentSizeCategory = true
        modelLabel.text = "Model: \(model)"
        modelLabel.numberOfLines = 1
        modelLabel.isAccessibilityElement = true
        modelLabel.accessibilityLabel = "Model: \(model)"
        
        priceLabel.font = UIFont.preferredFont(forTextStyle: .body)
        priceLabel.adjustsFontForContentSizeCategory = true
        priceLabel.text = "Price: \(price)"
        priceLabel.numberOfLines = 1
        priceLabel.isAccessibilityElement = true
        priceLabel.accessibilityLabel = "Price: \(price)"
        
        // Configure text stack view
        textStackView.axis = .vertical
        textStackView.distribution = .fillEqually
        textStackView.spacing = 8
        textStackView.addArrangedSubview(brandLabel)
        textStackView.addArrangedSubview(modelLabel)
        textStackView.addArrangedSubview(priceLabel)
        
        // Create a spacer view with a minimal width for a very subtle shift
        let spacerView = UIView()
        spacerView.translatesAutoresizingMaskIntoConstraints = false
        spacerView.widthAnchor.constraint(equalToConstant: 10).isActive = true
        
        // Configure main stack view
        mainStackView.axis = .horizontal
        mainStackView.spacing = 0
        mainStackView.distribution = .fill
        mainStackView.addArrangedSubview(carImageView)
        mainStackView.addArrangedSubview(spacerView)
        mainStackView.addArrangedSubview(textStackView)
        
        addSubview(mainStackView)
        
        // Set up constraints for main stack view
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            carImageView.widthAnchor.constraint(equalTo: mainStackView.widthAnchor, multiplier: 0.6)
        ])
    }
    
    func updateContent(image: UIImage?, brand: String, model: String, price: String) {
        carImageView.image = image
        brandLabel.text = "Brand: \(brand)"
        brandLabel.accessibilityLabel = "Brand: \(brand)"
        modelLabel.text = "Model: \(model)"
        modelLabel.accessibilityLabel = "Model: \(model)"
        priceLabel.text = "Price: \(price)"
        priceLabel.accessibilityLabel = "Price: \(price)"
    }
    
    func updateImage(image: UIImage) {
        carImageView.image = image
    }
}
