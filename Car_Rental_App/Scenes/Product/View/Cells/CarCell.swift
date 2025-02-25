import Foundation
import UIKit
import Kingfisher

class CarCell: UICollectionViewCell {
    
    // MARK: - Properties
    static let reuseIdentifier = "CarCell"
    
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.backgroundColor = .systemGray
        return imageView
    }()
    
    private let brandLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    private let modelLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    private let engineTypeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .darkGray
        return label
    }()
    
    private let msrpLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .black
        return label
    }()
    
    private let engineTypeAndMsrpStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupCellStyle()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
        setupCellStyle()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    private func setupCellStyle() {
        contentView.layer.cornerRadius = 12
        contentView.clipsToBounds = true
        
        contentView.backgroundColor = .lightGray
    }
    
    private func setupViews() {
        contentView.addSubview(imageView)
        imageView.addSubview(activityIndicator)
        contentView.addSubview(brandLabel)
        contentView.addSubview(modelLabel)
        contentView.addSubview(engineTypeAndMsrpStackView)
        
        engineTypeAndMsrpStackView.addArrangedSubview(engineTypeLabel)
        engineTypeAndMsrpStackView.addArrangedSubview(msrpLabel)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        brandLabel.translatesAutoresizingMaskIntoConstraints = false
        modelLabel.translatesAutoresizingMaskIntoConstraints = false
        engineTypeAndMsrpStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.7),
            
            activityIndicator.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            
            brandLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 4),
            brandLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8),
            brandLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8),
            
            modelLabel.topAnchor.constraint(equalTo: brandLabel.bottomAnchor, constant: 4),
            modelLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8),
            modelLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8),
            
            engineTypeAndMsrpStackView.topAnchor.constraint(equalTo: modelLabel.bottomAnchor, constant: 4),
            engineTypeAndMsrpStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8),
            engineTypeAndMsrpStackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8),
            engineTypeAndMsrpStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            engineTypeAndMsrpStackView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.1)
        ])
    }
    
    func configure(with brand: String, model: String, engineType: String, msrp: Int) {
        activityIndicator.startAnimating()
        let imageURLString = "https://cdn.imagin.studio/getimage?customer=img&zoomType=fullscreen&randomPaint=true&modelFamily=\(model)&make=\(brand)&modelYear=2020&angle=front"
        
        let url = URL(string: imageURLString)!
        
        imageView.kf.setImage(
            with: url,
            placeholder: nil,
            options: [
                .cacheOriginalImage
            ],
            progressBlock: { receivedSize, totalSize in
            },
            completionHandler: { [weak self] result in
                guard let self = self else { return }
                self.activityIndicator.stopAnimating()
            }
        )
        brandLabel.text = brand
        modelLabel.text = model
        engineTypeLabel.text = engineType
        msrpLabel.text = "$\(msrp)"
    }
}


/*"https://cdn.imagin.studio/getimage?customer=img&zoomType=fullscreen&paintdescription=Imagin-grey&modelFamily=\(model)&make=\(brand)&modelYear=2020&angle=front"
 &randomPaint=true
 */
