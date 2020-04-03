//
//  AuthenticationViewModel.swift
//  Mental Health
//
//  Created by Mihai Betej on 02/04/2020.
//  Copyright © 2020 Mihai Betej. All rights reserved.
//

import Foundation
import FirebaseAuth

// MARK: - AuthenticationViewModel

class AuthenticationViewModel {
    
    var email: String = ""
    var password: String = ""
    
    func signIn(with email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            
        }
    }
    
    func createUser(with email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            
        }
    }
    
}
