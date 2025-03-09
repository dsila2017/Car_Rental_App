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
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.backgroundColor = .tertiarySystemBackground // Updated for better contrast
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    private let brandLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .label // Adapts to light/dark mode
        return label
    }()
    
    private let modelLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .secondaryLabel // Softer contrast
        return label
    }()
    
    private let engineTypeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .tertiaryLabel // Even softer for metadata
        return label
    }()
    
    private let msrpLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .label
        return label
    }()
    
    private let engineTypeAndMsrpStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        return stackView
    }()
    
    private lazy var bottomStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [transmissionStack, wheelDriveStack, msrpStack])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let transmissionStack: CustomLogoStackView = {
        let stackView = CustomLogoStackView()
        stackView.configure(image: UIImage(systemName: "steeringwheel")!, color: .label, text: "Auto")
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let wheelDriveStack: CustomLogoStackView = {
        let stackView = CustomLogoStackView()
        stackView.configure(image: UIImage(systemName: "tire")!, color: .secondaryLabel, text: "FWD")
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let msrpStack: CustomLogoStackView = {
        let stackView = CustomLogoStackView()
        stackView.configure(image: UIImage(systemName: "dollarsign.gauge.chart.lefthalf.righthalf")!, color: .systemGreen, text: "$246900")
        stackView.translatesAutoresizingMaskIntoConstraints = false
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
        clearCell()
    }
    
    private func setupCellStyle() {
        contentView.layer.cornerRadius = 12
        contentView.clipsToBounds = true
        contentView.backgroundColor = .secondarySystemBackground // Updated for Apple's guidelines
    }
    
    private func setupViews() {
        contentView.addSubview(imageView)
        imageView.addSubview(activityIndicator)
        contentView.addSubview(brandLabel)
        contentView.addSubview(modelLabel)
        contentView.addSubview(bottomStackView)
        
        engineTypeAndMsrpStackView.addArrangedSubview(engineTypeLabel)
        engineTypeAndMsrpStackView.addArrangedSubview(msrpLabel)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        brandLabel.translatesAutoresizingMaskIntoConstraints = false
        modelLabel.translatesAutoresizingMaskIntoConstraints = false
        engineTypeAndMsrpStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            brandLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            brandLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8),
            brandLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8),
            brandLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.1),
            
            modelLabel.topAnchor.constraint(equalTo: brandLabel.bottomAnchor, constant: 0),
            modelLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8),
            modelLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8),
            modelLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.07),
            
            imageView.topAnchor.constraint(equalTo: modelLabel.bottomAnchor, constant: 8),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8),
            imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.55),
            
            activityIndicator.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            
            bottomStackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            bottomStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8),
            bottomStackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8),
            bottomStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    func configure(with brand: String, model: String, engineType: String, msrp: Int) {
        let imageURLString = "https://cdn.imagin.studio/getimage?customer=img&zoomType=fullscreen&randomPaint=true&modelFamily=\(model)&make=\(brand)&modelYear=2020&angle=front"
        
        guard let url = URL(string: imageURLString) else { return }

        activityIndicator.startAnimating()
        
        imageView.kf.setImage(
            with: url,
            options: [.cacheOriginalImage],
            completionHandler: { [weak self] result in
                self?.activityIndicator.stopAnimating()
            }
        )
        
        brandLabel.text = brand
        modelLabel.text = model
        engineTypeLabel.text = engineType
        msrpLabel.text = "$\(msrp)"
    }
    
    private func clearCell() {
        imageView.kf.cancelDownloadTask()
        imageView.image = nil
        brandLabel.text = nil
        modelLabel.text = nil
        engineTypeLabel.text = nil
        msrpLabel.text = nil
        activityIndicator.stopAnimating()
    }
}


/*"https://cdn.imagin.studio/getimage?customer=img&zoomType=fullscreen&paintdescription=Imagin-grey&modelFamily=\(model)&make=\(brand)&modelYear=2020&angle=front"
 &randomPaint=true
 */

class CustomLogoStackView: UIStackView {

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        //imageView.backgroundColor = .green
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 10, weight: .medium)
        label.textColor = .darkGray
        //label.backgroundColor = .yellow
        return label
    }()

    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        axis = .vertical
        distribution = .fillEqually
        alignment = .center
        spacing = 2
        
        addArrangedSubview(imageView)
        addArrangedSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalTo: self.widthAnchor),
            titleLabel.widthAnchor.constraint(equalTo: self.widthAnchor)
            ])
    }


    // MARK: - Configuration
    func configure(image: UIImage?, color: UIColor?, text: String) {
        imageView.image = image
        imageView.tintColor = color
        titleLabel.text = text
    }
}

enum AppColor {
    case customColor1
    case customColor2
    
    var color: UIColor {
        switch self {
        case .customColor1:
            return UIColor(red: 95/255.0, green: 96/255.0, blue: 191/255.0, alpha: 1.0) // RGB (95, 96, 191)
        case .customColor2:
            return UIColor(red: 94/255.0, green: 171/255.0, blue: 88/255.0, alpha: 1.0) // RGB (94, 171, 88)
        }
    }
}
