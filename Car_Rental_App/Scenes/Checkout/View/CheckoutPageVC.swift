//
//  CheckoutPage.swift
//  Car_Rental_App
//
//  Created by User on 24.03.25.
//
import UIKit

class CheckoutPageVC: UIViewController {
    
    private var isTradeInVisible = false
    var viewModel: CheckoutPageViewModel = CheckoutPageViewModel()
    
    lazy var mainStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 10
        return stack
    }()
    
    let purchaseLabel: UILabel = {
        let label = UILabel()
        label.text = "Checkout"
        let descriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .title1)
        let boldDescriptor = descriptor.addingAttributes([.traits: [UIFontDescriptor.TraitKey.weight: UIFont.Weight.bold]])
        label.font = UIFont(descriptor: boldDescriptor, size: 0)
        label.textColor = .label
        label.textAlignment = .left
        label.adjustsFontForContentSizeCategory = true
        label.isAccessibilityElement = true
        label.accessibilityLabel = "Checkout"
        return label
    }()
    
    private let tradeInLabel: UILabel = {
        let label = UILabel()
        label.text = "Trade In"
        let descriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .title1)
        let boldDescriptor = descriptor.addingAttributes([.traits: [UIFontDescriptor.TraitKey.weight: UIFont.Weight.bold]])
        label.font = UIFont(descriptor: boldDescriptor, size: 0)
        label.textColor = .label
        label.textAlignment = .left
        label.adjustsFontForContentSizeCategory = true
        label.isAccessibilityElement = true
        label.accessibilityLabel = "Trade In"
        return label
    }()
    
    private let tradeInText: UILabel = {
        let label = UILabel()
        label.text = "Want to trade in? Enter VIN below"
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textColor = .secondaryLabel
        label.textAlignment = .left
        label.adjustsFontForContentSizeCategory = true
        label.isAccessibilityElement = true
        label.accessibilityLabel = "Want to trade in? Enter VIN below"
        return label
    }()
    
    private let tradeInTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter VIN here"
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .systemBackground
        textField.isAccessibilityElement = true
        textField.accessibilityLabel = "Enter VIN here"
        return textField
    }()
    
    private lazy var enterButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "arrow.right.circle.fill"), for: .normal)
        button.tintColor = .black
        button.addAction(UIAction(handler: { [weak self] _ in
            self?.buttonPressed()
            print("VIN entered: \(self?.tradeInTextField.text ?? "x")")
        }), for: .touchUpInside)
        button.isAccessibilityElement = true
        button.accessibilityLabel = "Submit VIN"
        return button
    }()
    
    private lazy var tradeInTextFieldStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [tradeInTextField, enterButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .center
        return stackView
    }()
    
    private lazy var purchaseButton: UIButton = {
        let button = UIButton()
        var config = UIButton.Configuration.filled()
        config.title = "Purchase"
        config.baseBackgroundColor = .black
        config.baseForegroundColor = .white
        config.cornerStyle = .medium
        button.configuration = config
        button.addAction(UIAction(handler: { [weak self] _ in
            self?.tapPurchase()
        }), for: .touchUpInside)
        button.isAccessibilityElement = true
        button.accessibilityLabel = "Purchase"
        return button
    }()
    
    let tradeInVehicle: UILabel = {
        let label = UILabel()
        label.text = "Trade-In Car"
        label.font = .preferredFont(forTextStyle: .title1)
        label.textColor = .label
        label.textAlignment = .left
        label.adjustsFontForContentSizeCategory = true
        label.isAccessibilityElement = true
        label.accessibilityLabel = "Trade-In Car"
        return label
    }()
    
    private lazy var imageStackView: ImageStackView = {
        return ImageStackView(image: UIImage(systemName: "car")!, brand: "Tesla", model: "Model S", price: "$75,000")
    }()
    
    private lazy var tradeInImageStackView: ImageStackView = {
        return ImageStackView(image: UIImage(systemName: "car")!, brand: "Tesla", model: "Model S", price: "$75,000")
    }()
    
    private let loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.color = .gray
        indicator.hidesWhenStopped = true
        indicator.isAccessibilityElement = true
        indicator.accessibilityLabel = "Loading trade-in information"
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNav()
    }
    
    private func setupUI() {
        view.addSubview(mainStack)
        view.addSubview(loadingIndicator)
        view.backgroundColor = .systemBackground
        setupNav()
        setupMainStack()
        setupConstraints()
        changeTradeInVisibility(isHidden: true)
    }
    
    private func setupBindings() {
        viewModel.onVehicleUpdated = { [weak self] vehicle in
            print(vehicle.year.description)
            self?.tradeInImageStackView.updateContent(image: nil, brand: vehicle.make, model: vehicle.model, price: "-\(vehicle.trims.first?.msrp ?? 0) $")
            self?.changeVisibility()
            self?.showLoadingIndicator()
        }
        
        viewModel.onError = { [weak self] errorMessage in
            self?.hideLoadingIndicator()
            self?.showAlert(title: "Error", message: errorMessage)
        }
        
        viewModel.onVehicleImageUpdated = { [weak self] image in
            self?.tradeInImageStackView.updateImage(image: image)
            self?.hideLoadingIndicator()
        }
    }
    
    private func changeTradeInVisibility(isHidden: Bool) {
        self.tradeInVehicle.isHidden = isHidden
        self.tradeInImageStackView.isHidden = isHidden
    }
    
    private func setupNav() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupMainStack() {
        mainStack.addArrangedSubview(purchaseLabel)
        mainStack.addArrangedSubview(imageStackView)
        mainStack.addArrangedSubview(tradeInLabel)
        mainStack.addArrangedSubview(tradeInText)
        mainStack.addArrangedSubview(tradeInTextFieldStack)
        mainStack.addArrangedSubview(tradeInVehicle)
        mainStack.addArrangedSubview(tradeInImageStackView)
        mainStack.addArrangedSubview(purchaseButton)
    }
    
    func setupCar(image: UIImage, brand: String, model: String, price: String) {
        self.imageStackView.updateContent(image: image, brand: brand, model: model, price: price)
    }
    
    private func buttonPressed() {
        guard let vin = tradeInTextField.text, !vin.isEmpty else {
            self.showAlert(title: "VIN Error", message: "Please Enter a Valid VIN")
            return
        }
        
        guard vin.count == 17 else {
            self.showAlert(title: "VIN Error", message: "VIN must be 17 characters long")
            return
        }
        
        viewModel.vin = vin
    }
    
    private func changeVisibility() {
        self.isTradeInVisible = true
        self.changeTradeInVisibility(isHidden: false)
        self.showLoadingIndicator()
    }
    
    private func tapPurchase() {
        let vc = SuccessVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func showLoadingIndicator() {
        loadingIndicator.startAnimating()
        tradeInImageStackView.isHidden = true
    }
    
    private func hideLoadingIndicator() {
        loadingIndicator.stopAnimating()
        tradeInImageStackView.isHidden = false
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mainStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            mainStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            purchaseLabel.heightAnchor.constraint(equalTo: mainStack.heightAnchor, multiplier: 0.1),
            
            tradeInLabel.heightAnchor.constraint(equalTo: mainStack.heightAnchor, multiplier: 0.07),
            tradeInText.heightAnchor.constraint(equalTo: mainStack.heightAnchor, multiplier: 0.04),
            
            tradeInTextFieldStack.heightAnchor.constraint(equalTo: mainStack.heightAnchor, multiplier: 0.05),
            
            imageStackView.heightAnchor.constraint(equalTo: mainStack.heightAnchor, multiplier: 0.2),
            
            tradeInVehicle.heightAnchor.constraint(equalTo: mainStack.heightAnchor, multiplier: 0.1),
            tradeInImageStackView.heightAnchor.constraint(equalTo: mainStack.heightAnchor, multiplier: 0.2),
            
            purchaseButton.heightAnchor.constraint(equalTo: mainStack.heightAnchor, multiplier: 0.07),
            
            tradeInTextField.widthAnchor.constraint(equalTo: tradeInTextFieldStack.widthAnchor, multiplier: 0.9),
            
            loadingIndicator.centerXAnchor.constraint(equalTo: tradeInImageStackView.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: tradeInImageStackView.centerYAnchor),
        ])
    }
}

extension UIViewController {
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}
