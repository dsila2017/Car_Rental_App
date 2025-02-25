//
//  ProductViewModel.swift
//  Car_Rental_App
//
//  Created by David on 2/23/25.
//

import Foundation
import UIKit

class ProductViewModel {
    
    private let networkManager: NetworkManager = NetworkManager.shared
    
    var brandList: [String] = ["Tesla", "Toyota", "Honda", "Ford", "Nissan", "Audi", "BMW", "Volvo", "Mercedes", "Kia"]
    
    var mainTextLabel: String = "Featured"
    
    var carList: [Engine] = []
    
    var reloadCollectionView: (() -> Void)?
    var reloadUIComponents: (() -> Void)?
    
    func fetchCars(with: FetchType) {
        networkManager.fetchEngineData(with: with) { [weak self] result in
            switch result {
                case .success(let engineResponse):
                self?.carList = engineResponse
                self?.reloadCollectionView?()
                print(self?.carList.count)
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    func updateMainLabelText(to newText: String) {
        mainTextLabel = newText
        self.reloadUIComponents?()
    }
}
