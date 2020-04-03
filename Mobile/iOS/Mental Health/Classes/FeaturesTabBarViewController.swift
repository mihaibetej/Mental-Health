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

    lazy var viewModel = FeaturesTabBarViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        viewModel.startObservingAuthenticationEvents()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        guard viewModel.isUserLoggedIn == false else  {
            return
        }
        
        guard let authController = UIStoryboard(name: "Authentication", bundle: nil).instantiateInitialViewController() else {
            return
        }
        
        present(authController, animated: true, completion: nil)
    }
    
}
