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
    @IBOutlet weak var signInContainerViewVCenterConstraint: NSLayoutConstraint!
    @IBOutlet weak var usernameTextField: MHTextField!
    @IBOutlet weak var passwordTextField: MHTextField!
    @IBOutlet weak var authenticationButton: MHButton!
    @IBOutlet weak var changeStateButton: UIButton!
    @IBOutlet weak var changeStateLabel: MHLabel!
    @IBOutlet weak var changeStateStackBottomConstraint: NSLayoutConstraint!
    
    private enum State {
        case signIn
        case signUp
    }
    
    private var state: State = .signIn {
        didSet {
            switch state {
            case .signIn:
                changeStateButton.setTitle("Creaza unul", for: .normal)
                changeStateLabel.text = "Nu ai deja cont? "
                authenticationButton.setTitle("Autentificare", for: .normal)
            case .signUp:
                changeStateButton.setTitle("Autentifica-te", for: .normal)
                changeStateLabel.text = "Ai deja cont? "
                authenticationButton.setTitle("Creeaza cont", for: .normal)
            }
        }
    }
    
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
    
    @IBAction func changeState(_ sender: Any) {
        state = (state == .signIn) ? .signUp : .signIn
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

