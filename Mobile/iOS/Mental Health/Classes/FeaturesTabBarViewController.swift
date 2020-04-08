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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard checkAndSignInIfNeccesary() == false else {
            return
        }
        checkAndPresentDailyFeedbackIfNeccesary()
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
    
}

// MARK: - FeaturesTabBarViewController (private API)

private extension FeaturesTabBarViewController {
    
    @discardableResult
    func checkAndSignInIfNeccesary() -> Bool {
        guard viewModel.isUserLoggedIn == false else  {
            //viewModel.signOut()
            InternalUser.update { _ in}
            return false
        }
        
        guard let authController = UIStoryboard(name: "Authentication", bundle: nil).instantiateInitialViewController() else {
            return false
        }
        
        present(authController, animated: true, completion: nil)
        return true
    }
    
    func checkAndPresentDailyFeedbackIfNeccesary() {
        //TODO: Present 'Cum te simti azi' dialog 
    }
    
}
