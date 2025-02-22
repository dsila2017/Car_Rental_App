//
//  SignInViewModel.swift
//  Car_Rental_App
//
//  Created by David on 2/23/25.
//

import Foundation
import FirebaseAuth

class SignInViewModel {

    // Method for signing in a user
    func signIn(email: String, password: String, authenticationCompletion: @escaping (Result<Void, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                
                authenticationCompletion(.failure(error))
                return
            }
            
            authenticationCompletion(.success(()))
        }
    }
}
