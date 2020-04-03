//
//  AuthenticationViewModel.swift
//  Mental Health
//
//  Created by Mihai Betej on 02/04/2020.
//  Copyright © 2020 Mihai Betej. All rights reserved.
//

import Foundation
import FirebaseAuth

// MARK: - AuthenticationViewModelDelegate

protocol AuthenticationViewModelDelegate: class {
    func didSignIn()
    func failedToSignIn(with: Error)
    func didCreateUser()
    func failedToCreateUser(with: Error)
}

// MARK: - AuthenticationViewModel

class AuthenticationViewModel {
    
    weak var delegate: AuthenticationViewModelDelegate?
    
    func isValid(email: String?) -> Bool {
        guard email != nil else {
            return false
        }
        
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        
        return emailTest.evaluate(with: email)
    }
    
    func isValid(password: String?) -> Bool {
        return (password ?? "").count > 4
    }
    
    func signIn(with email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] (result, error) in
            if let error = error {
                // User login failed
                print("sign in error: \(error)")
                self?.delegate?.failedToSignIn(with: error)
            } else if let result = result {
                // User logged in
                print("sign in result: \(result)")
                self?.delegate?.didSignIn()
            } else {
                // shrug...
            }
            
        }
    }
    
    func createUser(with email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] (result, error) in
            if let error = error {
                // User login failed
                print("create user error: \(error)")
                self?.delegate?.failedToCreateUser(with: error)
            } else if let result = result {
                // User logged in
                print("create user result: \(result)")
                self?.delegate?.didCreateUser()
            } else {
                // shrug...
            }
        }
    }
    
}
