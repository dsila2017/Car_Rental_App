//
//  BrandCell.swift
//  Car_Rental_App
//
//  Created by David on 2/23/25.
//

import UIKit

class BrandCell: UICollectionViewCell {
    static let reuseIdentifier = "BrandCell"
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor = .black
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(logoImageView)
        contentView.addSubview(nameLabel)
        
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            logoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            logoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            logoImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.7),
            
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(name: String) {
        logoImageView.image = UIImage(named: name)
        nameLabel.text = name
    }
}
