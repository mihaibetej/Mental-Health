//
//  FeaturesTabBarViewModel.swift
//  Mental Health
//
//  Created by Mihai Betej on 03/04/2020.
//  Copyright © 2020 Mihai Betej. All rights reserved.
//

import Foundation
import FirebaseAuth

// MARK: - FeaturesTabBarViewModelDelegate

protocol FeaturesTabBarViewModelDelegate: class {
    func userDidSignOut()
    func appDidBecomeActive()
}

// MARK: - FeaturesTabBarViewModel

class FeaturesTabBarViewModel {
        
    // MARK: Variables
    
    weak var delegate: FeaturesTabBarViewModelDelegate?
    
    // MARK: Public API
    
    func startObservingAuthenticationEvents() {
        Auth.auth().addStateDidChangeListener { [weak self] (auth, user) in
            guard let user = user else {
                print("AUTH STATE LISTENER: User signed out!!!")
                self?.delegate?.userDidSignOut()
                return
            }
            
            print("Auth state changed: \(auth), \(user)")
        }
    }
        
    var isUserSignedIn: Bool {
        return Auth.auth().currentUser != nil
    }
    
    func signOut() {
        if isUserSignedIn {
            do {
               try Auth.auth().signOut()
                print("User successfuly signed out")
            } catch {
                print("WARNING: Failed to sign out user!")
            }
        }
    }
    
    var isCheckInNeeded: Bool {
        return Session.shared.isCheckInNeeded
    }
    
    func startObservingAppStateChanges() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleAppDidBecomeActive(for:)), name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    func stopObservingAppStateChanges() {
        NotificationCenter.default.removeObserver(self)
    }
    
}

// MARK: FeaturesTabBarViewModel (private API)

private extension FeaturesTabBarViewModel {
    
    @objc func handleAppDidBecomeActive(for notification: Notification) {
        delegate?.appDidBecomeActive()
    }
    
}
