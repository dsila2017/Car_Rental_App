//
//  CarModel.swift
//  Car_Rental_App
//
//  Created by David on 2/23/25.
//

import Foundation
import UIKit

struct CarModel {
    let brand: String
    let model: String
    let engine: String
    let year: Int
    let price: Int
    let image: UIImage
}

// Wrapper for the root dictionary (the root key is "data")
struct EngineResponse: Decodable {
    let data: [Engine]  // Array of Engine objects
}

// Engine Model
struct Engine: Decodable {
    let engineType: String
    let makeModelTrim: MakeModelTrim
    
    enum CodingKeys: String, CodingKey {
        case engineType = "engine_type"
        case makeModelTrim = "make_model_trim"
    }
}

// MakeModel Model
struct MakeModelTrim: Decodable {
    let name: String
    let makeModel: MakeModel
    let year: Int
    let msrp: Int
    
    enum CodingKeys: String, CodingKey {
            case name
            case makeModel = "make_model"
            case year
            case msrp
        }
}

// Make Model
struct MakeModel: Decodable {
    let name: String
    let make: Make
}

struct Make: Decodable {
    let name: String
}
