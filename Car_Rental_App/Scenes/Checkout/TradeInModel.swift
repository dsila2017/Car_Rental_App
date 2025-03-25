//
//  TradeInModel.swift
//  Car_Rental_App
//
//  Created by User on 24.03.25.
//

import Foundation

struct Vehicle: Decodable {
    let year: Int
    let make: String
    let model: String
    let trim: String
    let specs: Specs
    let trims: [Trim]

    struct Specs: Decodable {
        let bodyClass: String?
        let cabType: String?
        let displacementL: String?
        let doors: String?
        let driveType: String?
        let engineConfiguration: String?
        let engineNumberOfCylinders: String?
        let fuelTypePrimary: String?
        let grossVehicleWeightRatingFrom: String?
        let numberOfSeatRows: String?
        let numberOfSeats: String?
        let transmissionSpeeds: String?
        let transmissionStyle: String?
        let valveTrainDesign: String?
        let wheelBaseType: String?
        let wheelSizeFrontInches: String?
        let wheelSizeRearInches: String?

        enum CodingKeys: String, CodingKey {
            case bodyClass = "body_class"
            case cabType = "cab_type"
            case displacementL = "displacement_l"
            case doors
            case driveType = "drive_type"
            case engineConfiguration = "engine_configuration"
            case engineNumberOfCylinders = "engine_number_of_cylinders"
            case fuelTypePrimary = "fuel_type_primary"
            case grossVehicleWeightRatingFrom = "gross_vehicle_weight_rating_from"
            case numberOfSeatRows = "number_of_seat_rows"
            case numberOfSeats = "number_of_seats"
            case transmissionSpeeds = "transmission_speeds"
            case transmissionStyle = "transmission_style"
            case valveTrainDesign = "valve_train_design"
            case wheelBaseType = "wheel_base_type"
            case wheelSizeFrontInches = "wheel_size_front_inches"
            case wheelSizeRearInches = "wheel_size_rear_inches"
        }
    }

    struct Trim: Decodable {
        let id: Int
        let makeModelId: Int
        let year: Int
        let name: String
        let description: String
        let msrp: Int
        let invoice: Int
        let created: String
        let modified: String
        let makeModel: MakeModel

        enum CodingKeys: String, CodingKey {
            case id
            case makeModelId = "make_model_id"
            case year
            case name
            case description
            case msrp
            case invoice
            case created
            case modified
            case makeModel = "make_model"
        }
    }

    struct MakeModel: Decodable {
        let id: Int
        let makeId: Int
        let name: String
        let make: Make

        enum CodingKeys: String, CodingKey {
            case id
            case makeId = "make_id"
            case name
            case make
        }
    }

    struct Make: Decodable {
        let id: Int
        let name: String
    }
}
