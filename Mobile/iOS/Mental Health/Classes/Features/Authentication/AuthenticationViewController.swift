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
    
    private lazy var viewModel: AuthenticationViewModel = {
        let vm = AuthenticationViewModel()
        vm.delegate = self
        
        return vm
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Customize
        if #available(iOS 13.0, *) {
            isModalInPresentation = true
        }
        authenticationButton.isEnabled = false
        signInContainerView.backgroundColor = .clear
    }
    
    @IBAction func authenticateUser(_ sender: Any) {
        viewModel.signIn(with: usernameTextField.text ?? "", password: passwordTextField.text ?? "")
    }
    
}

// MARK: - AuthenticationViewController (AuthenticationViewModelDelegate)

extension AuthenticationViewController: AuthenticationViewModelDelegate {
    
    func didSignIn() {
        dismiss(animated: true, completion: nil)
    }
    
    func failedToSignIn(with: Error) {
        
    }
    
    func didCreateUser() {
        
    }
    
    func failedToCreateUser(with: Error) {
        
    }
    
}

// MARK: - AuthenticationViewController (UITextFieldDelegate)

extension AuthenticationViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case usernameTextField:
            usernameTextField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
        case passwordTextField:
            passwordTextField.resignFirstResponder()
            if authenticationButton.isEnabled {
                viewModel.signIn(with: usernameTextField.text!, password: passwordTextField.text!)
            }
        default:
            break
        }
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else {
            return true
        }
        
        let newText = (text as NSString).replacingCharacters(in: range, with: string)
        
        if textField == usernameTextField {
            authenticationButton.isEnabled = viewModel.isValid(email: newText) && viewModel.isValid(password: passwordTextField.text)
        } else if textField == passwordTextField {
            authenticationButton.isEnabled = viewModel.isValid(password: newText) && viewModel.isValid(email: usernameTextField.text)
        }
        
        return true
    }
    
}

