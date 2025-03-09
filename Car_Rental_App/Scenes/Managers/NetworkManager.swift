//
//  NetworkManager.swift
//  Car_Rental_App
//
//  Created by David on 2/23/25.
//

import Foundation
import UIKit

public class NetworkManager {
    // MARK: Properties
    static let shared = NetworkManager()
    
    // MARK: Methods
    func fetchData<T: Decodable>(url: String, completion: @escaping (Result<T,Error>) -> Void) {
        guard let url = URL(string: url) else { return }
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            if let error {
                completion(.failure(error))
            }
            
            if let response = response as? HTTPURLResponse {
                guard(200...299).contains(response.statusCode) else {
                    DispatchQueue.main.async {
                        completion(.failure(NetworkError.httpError(statusCode: response.statusCode)))
                    }
                    return
                }
            }
            
            guard let data else { return }
            
            do {
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(decodedData))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(NetworkError.noData))
                }
            }
            
        })
        task.resume()
        
    }
    
    func fetchImage(url: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
            
            if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                DispatchQueue.main.async {
                    completion(.failure(NetworkError.httpError(statusCode: response.statusCode)))
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(NetworkError.noData))
                }
                return
            }
            
            guard let image = UIImage(data: data) else {
                DispatchQueue.main.async {
                    completion(.failure(NetworkError.decodingFailed))
                }
                return
            }
            
            DispatchQueue.main.async {
                completion(.success(image))
            }
        }
        task.resume()
    }
    
    private func fetchDataAPI<T: Decodable>(url: String, headers: [String: String]?, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: url) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        // Add headers if provided
        if let headers = headers {
            for (key, value) in headers {
                request.addValue(value, forHTTPHeaderField: key)
            }
        }
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            
            if let response = response as? HTTPURLResponse {
                guard (200...299).contains(response.statusCode) else {
                    DispatchQueue.main.async {
                        completion(.failure(NetworkError.httpError(statusCode: response.statusCode)))
                    }
                    return
                }
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(NetworkError.noData))
                }
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(decodedData))
                }
            } catch let decodingError {
                print("Decoding failed: \(decodingError.localizedDescription)")
                if let decodingError = decodingError as? DecodingError {
                    switch decodingError {
                    case .typeMismatch(let type, let context):
                        print("Type mismatch error: \(type), context: \(context)")
                    case .valueNotFound(let type, let context):
                        print("Value not found error: \(type), context: \(context)")
                    case .keyNotFound(let key, let context):
                        print("Key not found error: \(key), context: \(context)")
                    case .dataCorrupted(let context):
                        print("Data corrupted error: \(context)")
                    @unknown default:
                        print("Unknown decoding error")
                    }
                }
            }
        })
        task.resume()
    }

    
    func fetchEngineData(with: FetchType, completion: @escaping (Result<[Engine], Error>) -> Void) {
        let url = "https://car-api2.p.rapidapi.com/api/engines?limit=24&verbose=yes&year=2020&page=1&direction=desc&sort=\(with)"
        
        let headers = [
            "x-rapidapi-key": "cf9c2725b9msh661dfd01332799ap12f657jsn999a050acd54",
            "x-rapidapi-host": "car-api2.p.rapidapi.com"
        ]
        
        fetchDataAPI(url: url, headers: headers) { (result: Result<EngineResponse, Error>) in
            switch result {
            case .success(let response):
                completion(.success(response.data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }


    
    enum NetworkError: Error {
        case invalidURL, httpError(statusCode: Int), noData, decodingFailed
    }
}

enum FetchType {
    case size, horsepower_hp, transmission, fuel_type
}
