import UIKit

class CarDetailsViewController: UIViewController {
    
    lazy var descriptionScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentSize = CGSize(width: view.bounds.width, height: view.bounds.height * 1.5)
        scrollView.backgroundColor = .systemBackground
        return scrollView
    }()
    
    var mainImageView: UIImageView = {
        var image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "car")
        image.tintColor = UIColor.label
        return image
    }()
    
    private let tileStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 24
        return stackView
    }()
    
    private let firstTile: TileView = {
        let view = TileView()
        view.translatesAutoresizingMaskIntoConstraints = false
        let config = UIImage.SymbolConfiguration(pointSize: 14, weight: .medium)
        view.configure(image: UIImage(systemName: "engine.combustion", withConfiguration: config), name: "Engine", value: "1200 HP")
        view.tintColor = UIColor.label
        return view
    }()
    
    private let secondTile: TileView = {
        let view = TileView()
        view.translatesAutoresizingMaskIntoConstraints = false
        let config = UIImage.SymbolConfiguration(weight: .medium)
        view.configure(image: UIImage(systemName: "transmission", withConfiguration: config), name: "Gearbox", value: "Automatic")
        view.tintColor = UIColor.label
        return view
    }()
    
    var thirdTile: TileView = {
        let view = TileView()
        view.translatesAutoresizingMaskIntoConstraints = false
        let config = UIImage.SymbolConfiguration(weight: .medium)
        view.configure(image: UIImage(systemName: "fuelpump", withConfiguration: config), name: "Fuel", value: "Gas")
        view.tintColor = UIColor.label
        return view
    }()
    
    private let priceStack = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillEqually
        return stack
    }()
    
    private let totalPriceLabel: UILabel = {
        let label = UILabel()
        label.text = "Total Price"
        label.font = UIFont.preferredFont(forTextStyle: .headline) // Use headline style
        label.adjustsFontForContentSizeCategory = true // Enable Dynamic Type
        label.textColor = UIColor.label // Semantic color
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "$ 90000"
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = UIColor.secondaryLabel
        return label
    }()
    
    private lazy var purchaseButton: UIButton = {
        let button = UIButton()
        var config = UIButton.Configuration.filled()
        config.title = "Checkout"
        config.baseBackgroundColor = .black
        config.baseForegroundColor = .white
        config.cornerStyle = .medium
        button.configuration = config
        button.addAction(UIAction(handler: { [weak self] _ in
            let vc = CheckoutPageVC()
            vc.setupCar(image: (self?.mainImageView.image)!, brand: (self?.brandStack.rightLabel.text)!, model: (self?.modelStack.rightLabel.text)!, price: (self?.priceLabel.text)!)
            self?.navigationController?.pushViewController(vc, animated: true)
        }), for: .touchUpInside)
        return button
    }()
    
    private let bottomStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        return stack
    }()
    
    private let brandStack: CustomInfoStack = {
        let stack = CustomInfoStack(leftText: "Brand:", rightText: "")
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let modelStack: CustomInfoStack = {
        let stack = CustomInfoStack(leftText: "Model:", rightText: "")
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let yearStack: CustomInfoStack = {
        let stack = CustomInfoStack(leftText: "Year:", rightText: "")
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let engineTypeStack: CustomInfoStack = {
        let stack = CustomInfoStack(leftText: "Engine:", rightText: "")
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let fuelTypeStack: CustomInfoStack = {
        let stack = CustomInfoStack(leftText: "Fuel:", rightText: "")
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let horsepowerStack: CustomInfoStack = {
        let stack = CustomInfoStack(leftText: "Horsepower:", rightText: "")
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let cylindersStack: CustomInfoStack = {
        let stack = CustomInfoStack(leftText: "Cylinders:", rightText: "")
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let transmissionStack: CustomInfoStack = {
        let stack = CustomInfoStack(leftText: "Transmission:", rightText: "")
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let driveTypeStack: CustomInfoStack = {
        let stack = CustomInfoStack(leftText: "Drive Type:", rightText: "")
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var mainInfoStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 14
        stack.axis = .vertical
        return stack
    }()
    
    private let viewModel = CarDetailsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground
        
        setupUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.largeTitleTextAttributes = nil
    }
    
    func setupView(carModel: Engine, image: UIImage?) {
        mainImageView.image = image
        firstTile.configure(value: carModel.horsepower?.description ?? "0")
        secondTile.configure(value: viewModel.gearTransformer(string: carModel.transmission))
        thirdTile.configure(value: carModel.engineType)
        
        setupStacks(carModel: carModel)
    }
    
    private func setupStacks(carModel: Engine) {
        brandStack.updateLabel(rightText: carModel.makeModelTrim.makeModel.make.name)
        modelStack.updateLabel(rightText: carModel.makeModelTrim.makeModel.name)
        yearStack.updateLabel(rightText: carModel.makeModelTrim.year.description)
        engineTypeStack.updateLabel(rightText: carModel.engineType.description)
        fuelTypeStack.updateLabel(rightText: carModel.fuelType)
        horsepowerStack.updateLabel(rightText: carModel.horsepower != nil ? "\(carModel.horsepower!.description) HP" : "-")
        cylindersStack.updateLabel(rightText: carModel.cylinders ?? "-")
        transmissionStack.updateLabel(rightText: carModel.transmission)
        driveTypeStack.updateLabel(rightText: carModel.driveType)
        self.title = "\(carModel.makeModelTrim.makeModel.make.name) \(carModel.makeModelTrim.makeModel.name)"
        priceLabel.text = carModel.makeModelTrim.msrp.description + " " + "$"
    }
    
    private func setupUI() {
        setupNavItems()
        setupMainStackView()
        setupPriceStack()
        setupBottomStack()
        view.addSubview(mainImageView)
        view.addSubview(tileStackView)
        view.addSubview(descriptionScrollView)
        descriptionScrollView
            .addSubview(mainInfoStack)
        setupInfoStackView()
        view.addSubview(bottomStack)
        setupConstraints()
    }
    
    private func setupInfoStackView() {
        mainInfoStack.addArrangedSubview(brandStack)
        mainInfoStack.addArrangedSubview(modelStack)
        mainInfoStack.addArrangedSubview(yearStack)
        mainInfoStack.addArrangedSubview(engineTypeStack)
        mainInfoStack.addArrangedSubview(horsepowerStack)
        mainInfoStack.addArrangedSubview(cylindersStack)
        mainInfoStack.addArrangedSubview(transmissionStack)
        mainInfoStack.addArrangedSubview(driveTypeStack)
        mainInfoStack.addArrangedSubview(fuelTypeStack)
    }
    
    private func setupMainStackView() {
        tileStackView.addArrangedSubview(firstTile)
        tileStackView.addArrangedSubview(secondTile)
        tileStackView.addArrangedSubview(thirdTile)
    }
    
    private func setupPriceStack() {
        priceStack.addArrangedSubview(totalPriceLabel)
        priceStack.addArrangedSubview(priceLabel)
    }
    
    private func setupBottomStack() {
        bottomStack.addArrangedSubview(priceStack)
        bottomStack.addArrangedSubview(purchaseButton)
    }
    
    private func setupNavItems() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        //self.title = "Car Details"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Main Image View Constraints
            mainImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            mainImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.24),
            mainImageView.widthAnchor.constraint(equalTo: mainImageView.heightAnchor, multiplier: 1.5),
            mainImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // Tile Stack View Constraints
            tileStackView.topAnchor.constraint(equalTo: mainImageView.bottomAnchor, constant: 20),
            tileStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 34),
            tileStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -34),
            tileStackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1),
            
            // Description Scroll View Constraints
            descriptionScrollView.topAnchor.constraint(equalTo: tileStackView.bottomAnchor, constant: 20),
            descriptionScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            descriptionScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            descriptionScrollView.bottomAnchor.constraint(equalTo: bottomStack.topAnchor, constant: -20),
            
            // Main Info Stack Constraints
            mainInfoStack.topAnchor.constraint(equalTo: descriptionScrollView.contentLayoutGuide.topAnchor, constant: 20),
            mainInfoStack.bottomAnchor.constraint(equalTo: descriptionScrollView.contentLayoutGuide.bottomAnchor, constant: -20),
            //mainInfoStack.leadingAnchor.constraint(equalTo: descriptionScrollView.frameLayoutGuide.leadingAnchor, constant: 24),
            //mainInfoStack.trailingAnchor.constraint(equalTo: descriptionScrollView.frameLayoutGuide.trailingAnchor, constant: -24),
            
            mainInfoStack.widthAnchor.constraint(equalTo: descriptionScrollView.frameLayoutGuide.widthAnchor, multiplier: 0.85),
            mainInfoStack.centerXAnchor.constraint(equalTo: descriptionScrollView.centerXAnchor),
            
            // Bottom Stack Constraints
            bottomStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            //bottomStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            //bottomStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            bottomStack.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05),
            
            bottomStack.widthAnchor.constraint(equalTo: descriptionScrollView.frameLayoutGuide.widthAnchor, multiplier: 0.85),
            bottomStack.centerXAnchor.constraint(equalTo: descriptionScrollView.centerXAnchor),
        ])
    }
    
    
}

class CustomInfoStack: UIStackView {
    
    private let leftLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true // Enable Dynamic Type
        label.textColor = UIColor.label // Semantic color
        return label
    }()
    
    let rightLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true // Enable Dynamic Type
        label.textColor = UIColor.secondaryLabel // Semantic color for less emphasis
        return label
    }()
    
    init(leftText: String, rightText: String) {
        super.init(frame: .zero)
        leftLabel.text = leftText
        rightLabel.text = rightText
        setupStackView()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupStackView()
    }
    
    private func setupStackView() {
        axis = .horizontal
        distribution = .equalSpacing
        alignment = .center
        spacing = 8
        addArrangedSubview(leftLabel)
        addArrangedSubview(rightLabel)
    }
    
    func updateLabel(rightText: String) {
        rightLabel.text = rightText
    }
}
