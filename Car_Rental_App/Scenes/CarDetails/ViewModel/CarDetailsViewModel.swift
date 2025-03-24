//
//  CarDetailsViewModel.swift
//  Car_Rental_App
//
//  Created by User on 11.03.25.
//

import Foundation

final class CarDetailsViewModel {
    
    func gearTransformer(string: String) -> String {
        if string.contains("manual") {
            return "Manual"
        } else {
            return "Automatic"
        }
    }
}
