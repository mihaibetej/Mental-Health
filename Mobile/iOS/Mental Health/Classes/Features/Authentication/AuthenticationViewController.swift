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

    @IBOutlet weak var signInContainerView: UIStackView!
    @IBOutlet weak var signInContainerViewVCenterConstraint: NSLayoutConstraint!
    @IBOutlet weak var usernameTextField: MHTextField!
    @IBOutlet weak var passwordTextField: MHTextField!
    @IBOutlet weak var passwordConfirmationTextField: MHTextField!
    @IBOutlet weak var authenticationButton: MHButton!
    @IBOutlet weak var changeStateButton: UIButton!
    @IBOutlet weak var changeStateLabel: MHLabel!
    @IBOutlet weak var changeStateStackBottomConstraint: NSLayoutConstraint!
    
    
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
        signInContainerView.setCustomSpacing(38, after: passwordConfirmationTextField)
        viewModel.changeViewState()
        registerForKeyboardNotifications()
    }
    
    deinit {
        unregisterForKeyboardNotifications()
    }
    
    @IBAction func authenticateUser(_ sender: Any) {
        viewModel.signIn(with: usernameTextField.text ?? "", password: passwordTextField.text ?? "")
    }
    
    @IBAction func changeState(_ sender: Any) {
        viewModel.changeViewState()
    }
    
}

// MARK: - AuthenticationViewController (AuthenticationViewModelDelegate)

extension AuthenticationViewController: AuthenticationViewModelDelegate {
    
    func didChangeToSignInViewState() {
        changeStateButton.setTitle("Creaza unul", for: .normal)
        changeStateLabel.text = "Nu ai deja cont? "
        authenticationButton.setTitle("Autentificare", for: .normal)
        //signInContainerView.removeArrangedSubview(passwordConfirmationTextField)
        UIView.animate(withDuration: 0.25) {
            self.passwordConfirmationTextField.alpha = 0
        }
    }
    
    func didChangeToSignUpViewState() {
        changeStateButton.setTitle("Autentifica-te", for: .normal)
        changeStateLabel.text = "Ai deja cont? "
        authenticationButton.setTitle("Creeaza cont", for: .normal)
        UIView.animate(withDuration: 0.25) {
            self.passwordConfirmationTextField.alpha = 1
        }
    }
    
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

// MARK: - AuthenticationViewController (Keyboard avoidance)

extension AuthenticationViewController {
    
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(toggleKeyboard(notification:)),
                                               name: UIWindow.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(toggleKeyboard(notification:)),
                                               name: UIWindow.keyboardWillHideNotification,
                                               object: nil)
    }
    
    func unregisterForKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func toggleKeyboard(notification: Notification) {
        let animationDuration = notification.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
        let animationCurve = notification.userInfo![UIResponder.keyboardAnimationCurveUserInfoKey] as! UInt
        let currentFrame = (notification.userInfo![UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        let targetFrame = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let deltaY = targetFrame.origin.y - currentFrame.origin.y
                
        changeStateStackBottomConstraint.constant += (-1) * deltaY
        UIView.animate(withDuration: animationDuration, delay: 0, options: UIView.AnimationOptions(rawValue: animationCurve), animations: {
            self.view.layoutIfNeeded()
        }) { (finished) in
            // finished animating
        }
    }
    
}
