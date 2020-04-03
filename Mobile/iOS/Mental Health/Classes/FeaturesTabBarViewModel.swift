//
//  FeaturesTabBarViewModel.swift
//  Mental Health
//
//  Created by Mihai Betej on 03/04/2020.
//  Copyright © 2020 Mihai Betej. All rights reserved.
//

import Foundation
import FirebaseAuth

// MARK: - FeaturesTabBarViewModel

class FeaturesTabBarViewModel {
            
    func startObservingAuthenticationEvents() {
        Auth.auth().addStateDidChangeListener { (auth, user) in
            guard let user = user else {
                print("AUTH STATE LISTENER: User signed out!!!")
                return
            }
            
            print("Auth state changed: \(auth), \(user)")
        }
    }
    
    var isUserLoggedIn: Bool {
        return Auth.auth().currentUser != nil
    }
    
    func signOut() {
        if isUserLoggedIn {
            do {
               try Auth.auth().signOut()
                print("User successfuly signed out")
            } catch {
                print("WARNING: Failed to sign out user!")
            }
        }
    }
}
