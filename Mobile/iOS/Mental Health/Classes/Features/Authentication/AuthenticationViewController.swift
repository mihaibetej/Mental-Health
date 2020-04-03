//
//  AuthenticationViewController.swift
//  Mental Health
//
//  Created by Mihai Betej on 02/04/2020.
//  Copyright © 2020 Mihai Betej. All rights reserved.
//

import UIKit

// MARK: - AuthenticationViewController

class AuthenticationViewController: UIViewController {

    @IBOutlet weak var signInContainerView: UIView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var authenticationButton: UIButton!
    
    private lazy var viewModel = AuthenticationViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Customize
        if #available(iOS 13.0, *) {
            isModalInPresentation = true
        } 
        signInContainerView.backgroundColor = .clear
    }
    
    @IBAction func authenticateUser(_ sender: Any) {
        viewModel.signIn(with: usernameTextField.text ?? "", password: passwordTextField.text ?? "")
    }
}

extension AuthenticationViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    
}

