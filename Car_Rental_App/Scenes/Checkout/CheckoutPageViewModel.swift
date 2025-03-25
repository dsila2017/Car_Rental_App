//
//  CheckoutPageViewModel.swift
//  Car_Rental_App
//
//  Created by User on 24.03.25.
//

import Foundation
import UIKit

class CheckoutPageViewModel {
    
    var vin: String = "" {
        didSet {
            fetch(vin: vin)
        }
    }
    
    var onVehicleUpdated: ((Vehicle) -> Void)?
    var onVehicleImageUpdated: ((UIImage) -> Void)?
    var onError: ((String) -> Void)?
    
    func fetch(vin: String) {
        NetworkManager.shared.fetchEngineData(url: "https://car-api2.p.rapidapi.com/api/vin/\(vin)") { [weak self] (result: Result<Vehicle, Error>) in
            switch result {
            case .success(let vehicle):
                self?.onVehicleUpdated?(vehicle)
                self?.fetchImage(brand: vehicle.make, model: vehicle.model.description)
                print(vehicle.make)
            case .failure(let error):
                self?.onError?(error.localizedDescription)
            }
        }
    }
    
    func fetchImage(brand: String, model: String) {
        NetworkManager.shared.fetchImage(url: "https://cdn.imagin.studio/getimage?customer=img&zoomType=fullscreen&randomPaint=true&modelFamily=\(model)&make=\(brand)&modelYear=2020&angle=front") { [weak self] (result: Result<UIImage, Error>) in
            switch result {
            case .success(let image):
                self?.onVehicleImageUpdated?(image)
            case .failure(let error):
                self?.onError?(error.localizedDescription)
            }
        }
    }
    
    func enterButtonPressed(vin: String) {
        
    }
}
