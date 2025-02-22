//
//  SignUpViewModel.swift
//  Car_Rental_App
//
//  Created by David on 2/21/25.
//

import Foundation
import FirebaseAuth

class SignUpViewModel {
    
    func signUp(email: String, password: String, authenticationCompletion: @escaping (Result<Void, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                
                authenticationCompletion(.failure(error))
                return
            }
            
            authenticationCompletion(.success(()))
        }
    }
}
