//
//  FeaturesTabBarViewController.swift
//  Mental Health
//
//  Created by Mihai Betej on 03/04/2020.
//  Copyright © 2020 Mihai Betej. All rights reserved.
//

import UIKit

// MARK: - FeaturesTabBarViewController

class FeaturesTabBarViewController: UITabBarController {

    lazy var viewModel: FeaturesTabBarViewModel = {
        let viewModel = FeaturesTabBarViewModel()
        viewModel.delegate = self
        
        return viewModel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        viewModel.startObservingAuthenticationEvents()
        viewModel.startObservingAppStateChanges()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard checkAndSignInIfNeccesary() == false else {
            return
        }
        checkAndPresentCheckInIfNeccesary()
    }
    
    deinit {
        viewModel.stopObservingAppStateChanges()
    }
    
}

// MARK: - FeaturesTabBarViewController (FeaturesTabBarViewModelDelegate)

extension FeaturesTabBarViewController: FeaturesTabBarViewModelDelegate {
    
    func userDidSignOut() {
        checkAndSignInIfNeccesary()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) { [weak self] in
            self?.selectedIndex = 0
        }
    }
    
    func appDidBecomeActive() {
        checkAndPresentCheckInIfNeccesary()
    }
    
}

extension FeaturesTabBarViewController: CheckinViewControllerDelegate {
    
    func checkInResultsGood() {
        // Alles gut, nothing needs to change atm
        // Maybe a pat on the back would be in order?
        Session.shared.addCheckIn()
    }
    
    func checkInResultsFurtherInvestigate() {
        // Redirect to Questionnaire
        if selectedIndex != 2 {
            selectedIndex = 2
        }
        Session.shared.addCheckIn()
    }
    
    func checkInDismissed() {
        // ¯\_(ツ)_/¯
    }
    
}

// MARK: - FeaturesTabBarViewController (private API)

private extension FeaturesTabBarViewController {
    
    @discardableResult
    func checkAndSignInIfNeccesary() -> Bool {
        guard viewModel.isUserSignedIn == false else  {
            InternalUser.fetchUserData { _ in
                InternalUser.update { _ in}
            }
            return false
        }
        
        guard let authController = UIStoryboard(name: "Authentication", bundle: nil).instantiateInitialViewController() else {
            return false
        }
        
        present(authController, animated: true, completion: nil)
        return true
    }
    
    func checkAndPresentCheckInIfNeccesary() {
        guard viewModel.isCheckInNeeded == true else {
            return
        }
        
        guard let checkinViewController = UIStoryboard(name: "CheckIn", bundle: nil).instantiateInitialViewController() as? CheckInViewController else {
            return
        }
        checkinViewController.delegate = self
        
        present(checkinViewController, animated: true, completion: nil)
    }
    
}
