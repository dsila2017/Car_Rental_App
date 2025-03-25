//
//  ProductViewModel.swift
//  Car_Rental_App
//
//  Created by David on 2/23/25.
//

import Foundation

class ProductViewModel {
    
    private let networkManager: NetworkManager = NetworkManager.shared
    
    var brandList = BrandList.allCases.map { $0 }
    var selectedBrand: BrandList?
    
    var mainTextLabel: String = "Featured"
    
    var carList: [Engine] = []
    
    var reloadCollectionView: (() -> Void)?
    var reloadUIComponents: (() -> Void)?
    
    func getCorrectURL(with: FetchType, brand: BrandList?) -> String {
        var url: String = ""
        
        url = "https://car-api2.p.rapidapi.com/api/engines?limit=24&verbose=yes&year=2020&page=1&direction=desc&sort=\(with)"
        
        guard let selectedBrand else {
            print(url)
            return url
        }
        
        url = "https://car-api2.p.rapidapi.com/api/engines?limit=24&verbose=yes&make_id=\(selectedBrand.rawValue)&year=2020&page=1&direction=desc&sort=\(with)"
        
        print(url)
        return url
    }
    
    func fetchCars(with: FetchType, brand: BrandList?) {
        networkManager.fetchEngineData(url: getCorrectURL(with: with, brand: brand)) { [weak self] (result: Result<EngineResponse, Error>) in
            switch result {
                case .success(let engineResponse):
                self?.carList = engineResponse.data
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

enum BrandList: Int, CaseIterable {
    case Tesla = 42
    case Toyota = 22
    case Honda = 9
    case Ford = 29
    case Nissan = 19
    case Audi = 2
    case BMW = 3
    case Volvo = 23
    case Mercedes = 37
    case Kia = 13
    
    var name: String {
            switch self {
            case .Tesla: return "Tesla"
            case .Toyota: return "Toyota"
            case .Honda: return "Honda"
            case .Ford: return "Ford"
            case .Nissan: return "Nissan"
            case .Audi: return "Audi"
            case .BMW: return "BMW"
            case .Volvo: return "Volvo"
            case .Mercedes: return "Mercedes"
            case .Kia: return "Kia"
            }
        }
}
