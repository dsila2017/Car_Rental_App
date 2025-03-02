//
//  ProductsViewController.swift
//  Car_Rental_App
//
//  Created by David on 2/23/25.
//

import UIKit
import Kingfisher

class ProductsViewController: UIViewController {
    
    private let networkManager = NetworkManager.shared
    
    lazy var brandsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Brands"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    lazy var logosCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    lazy var bestCarsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = viewModel.mainTextLabel
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()

    lazy var sortView: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Sort by", for: .normal)
        button.setTitleColor(.black, for: .normal)
        
        let menu = UIMenu(title: "Sort By", options: .displayInline, children: [
            UIAction(title: "Engine Type", image: UIImage(systemName: "engine.combustion"), handler: { [weak self] action in
                self?.handleSortAction(actionTitle: action.title, filterType: .transmission)
            }),
            UIAction(title: "Size", image: UIImage(systemName: "car.side"), handler: { [weak self] action in
                self?.handleSortAction(actionTitle: action.title, filterType: .size)
            }),
            
            UIAction(title: "Perfomance", image: UIImage(systemName: "tachometer"), handler: { [weak self] action in
                self?.handleSortAction(actionTitle: action.title, filterType: .horsepower_hp)
            })
        ])
        
        button.menu = menu
        button.showsMenuAsPrimaryAction = true
        return button
    }()

    
    lazy var bestCarsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private var viewModel: ProductViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        //navigationItem.title = "Hello User!"
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        viewModel = ProductViewModel()
        
        viewModel.reloadCollectionView = { [weak self] in
            self?.bestCarsCollectionView.reloadData()
        }
        viewModel.reloadUIComponents = { [weak self] in
            self?.reloadUIComponentsData()
        }
        
        viewModel.fetchCars(with: .size)
        
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        setupUI()
    }
    
    private func reloadUIComponentsData() {
        self.bestCarsLabel.text = viewModel.mainTextLabel
    }
    
    private func handleSortAction(actionTitle: String, filterType: FetchType) {
        scrollToTop()
        viewModel.updateMainLabelText(to: actionTitle)
        viewModel.fetchCars(with: filterType)
    }
    
    private func setupUI() {
        view.addSubview(brandsLabel)
        view.addSubview(logosCollectionView)
        view.addSubview(bestCarsLabel)
        view.addSubview(sortView)
        view.addSubview(bestCarsCollectionView)
        
        setupCollectionViews()
        setupConstraints()
    }
    
    private func setupCollectionViews() {
        setupLogoCollectionView()
        setupCarCollectionView()
    }
    
    private func scrollToTop() {
        let indexPath = IndexPath(item: 0, section: 0)
        bestCarsCollectionView.scrollToItem(at: indexPath, at: .top, animated: true)
    }
    
    private func setupLogoCollectionView() {
        logosCollectionView.delegate = self
        logosCollectionView.dataSource = self
        logosCollectionView.tag = 1
        
        logosCollectionView.register(BrandCell.self, forCellWithReuseIdentifier: BrandCell.reuseIdentifier)
    }
    
    private func setupCarCollectionView() {
        bestCarsCollectionView.delegate = self
        bestCarsCollectionView.dataSource = self
        bestCarsCollectionView.tag = 2
        
        bestCarsCollectionView.register(CarCell.self, forCellWithReuseIdentifier: CarCell.reuseIdentifier)
    }
    
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            brandsLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            brandsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            brandsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            
            logosCollectionView.topAnchor.constraint(equalTo: brandsLabel.bottomAnchor, constant: 20),
            logosCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            logosCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            logosCollectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1),
            
            bestCarsLabel.topAnchor.constraint(equalTo: logosCollectionView.bottomAnchor, constant: 20),
            bestCarsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            bestCarsLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            
            sortView.centerYAnchor.constraint(equalTo: bestCarsLabel.centerYAnchor),
            sortView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            bestCarsCollectionView.topAnchor.constraint(equalTo: bestCarsLabel.bottomAnchor, constant: 20),
            bestCarsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            bestCarsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            bestCarsCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
        ])
    }
    
}

extension ProductsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag {
        case 1:
            return viewModel.brandList.count
        case 2:
            return viewModel.carList.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView.tag {
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BrandCell.reuseIdentifier, for: indexPath) as! BrandCell
            cell.configure(name: viewModel.brandList[indexPath.row])
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarCell.reuseIdentifier, for: indexPath) as! CarCell
            let car = viewModel.carList[indexPath.row]
            cell.configure(with: car.makeModelTrim.makeModel.make.name, model: car.makeModelTrim.makeModel.name, engineType: car.engineType, msrp: car.makeModelTrim.msrp)
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    
}

extension ProductsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch collectionView.tag {
        case 1:
            let collectionViewHeight = collectionView.frame.height / 1.2
            return CGSize(width: collectionViewHeight, height: collectionViewHeight)
        case 2:
            let padding: CGFloat = 5
            let itemsPerRow: CGFloat = 2
            let totalHorizontalPadding = (itemsPerRow + 1) * padding
            let availableWidth = view.frame.width - 20 * 2
            
            let width = (availableWidth - totalHorizontalPadding) / itemsPerRow
            let height: CGFloat = width * 1.8
            
            return CGSize(width: width, height: height)
            
        default:
            return CGSize(width: 120, height: 150)
        }
    }
}

extension ProductsViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView.tag {
        case 1:
            print("Brand selected")
        case 2:
            print("Car selected")
        default:
            break
        }
    }
}
