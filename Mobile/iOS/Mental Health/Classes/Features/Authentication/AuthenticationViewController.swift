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
    @IBOutlet weak var changeStateContainerView: UIStackView!
    @IBOutlet weak var changeStateButton: UIButton!
    @IBOutlet weak var changeStateLabel: MHLabel!
    @IBOutlet weak var changeStateStackBottomConstraint: NSLayoutConstraint!
    
    
    private lazy var viewModel: AuthenticationViewModel = {
        let vm = AuthenticationViewModel()
        vm.delegate = self
        
        return vm
    }()
    
    // Default constraint constants
    var changeStateStackBottomConstraintConstant: CGFloat = 0
    var signInContainerViewVCenterConstraintConstant: CGFloat = 0
    
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        guard changeStateStackBottomConstraintConstant == 0 && signInContainerViewVCenterConstraintConstant == 0 else {
            return
        }
        
        changeStateStackBottomConstraintConstant = changeStateStackBottomConstraint.constant
        signInContainerViewVCenterConstraintConstant = signInContainerViewVCenterConstraint.constant
    }
    
    @IBAction func authenticateUser(_ sender: Any) {
        viewModel.authenticateUser(with: usernameTextField.text ?? "", password: passwordTextField.text ?? "")
    }
    
    @IBAction func changeState(_ sender: Any) {
        viewModel.changeViewState()
    }
    
}

// MARK: - AuthenticationViewController (AuthenticationViewModelDelegate)

extension AuthenticationViewController: AuthenticationViewModelDelegate {
    
    func didChangeToSignInViewState() {
        // Update change controls
        changeStateButton.setTitle("Creează unul", for: .normal)
        changeStateLabel.text = "Nu ai deja cont? "
        authenticationButton.setTitle("Autentificare", for: .normal)
        
        // Update sign in controls
        passwordTextField.returnKeyType = .go
        UIView.animate(withDuration: 0.25) {
            self.passwordConfirmationTextField.alpha = 0
        }
        
        resetInputs()
    }
    
    func didChangeToSignUpViewState() {
        // Update change controls
        changeStateButton.setTitle("Autentifică-te", for: .normal)
        changeStateLabel.text = "Ai deja cont? "
        authenticationButton.setTitle("Creează cont", for: .normal)
        
        // Update sign in controls
        passwordTextField.returnKeyType = .next
        UIView.animate(withDuration: 0.25) {
            self.passwordConfirmationTextField.alpha = 1
        }
        
        resetInputs()
    }
    
    func didSignIn() {
        dismiss(animated: true, completion: nil)
    }
    
    func failedToSignIn(with: Error) {
        // Some error handling
    }
    
    func didCreateUser() {
        dismiss(animated: true, completion: nil)
    }
    
    func failedToCreateUser(with: Error) {
        // some error handling
    }
    
}

// MARK: - AuthenticationViewController (UITextFieldDelegate)

extension AuthenticationViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == usernameTextField {
            guard let text = textField.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) else {
                usernameTextField.validationState = .isValid
                return
            }
            
            guard text.count > 0 else {
                usernameTextField.text = ""
                usernameTextField.validationState = .isValid
                return
            }
            
            if viewModel.isValid(email: textField.text) == false {
                usernameTextField.validationState = .isInvalid
            }
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == usernameTextField {
            usernameTextField.validationState = .isValid
        }
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case usernameTextField:
            passwordTextField.becomeFirstResponder()
            
        case passwordTextField:
            if viewModel.viewState == .signIn {
                if authenticationButton.isEnabled {
                    passwordTextField.resignFirstResponder()
                    viewModel.authenticateUser(with: usernameTextField.text!, password: passwordTextField.text!)
                }
            } else {
                passwordConfirmationTextField.becomeFirstResponder()
            }
            
        case passwordConfirmationTextField:
            if authenticationButton.isEnabled {
                passwordConfirmationTextField.resignFirstResponder()
                viewModel.authenticateUser(with: usernameTextField.text!, password: passwordTextField.text!)
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
        
        if viewModel.viewState == .signIn {
            if textField == usernameTextField {
                authenticationButton.isEnabled = viewModel.isValid(email: newText) && viewModel.isValid(password: passwordTextField.text)
            } else if textField == passwordTextField {
                authenticationButton.isEnabled = viewModel.isValid(password: newText) && viewModel.isValid(email: usernameTextField.text)
            }
        } else {
            if textField == usernameTextField {
                authenticationButton.isEnabled = viewModel.isValid(email: newText) && viewModel.isValid(password: passwordTextField.text) && viewModel.isValid(password: passwordConfirmationTextField.text)
            } else if textField == passwordTextField {
                authenticationButton.isEnabled = viewModel.isValid(password: newText) && viewModel.isValid(email: usernameTextField.text) && viewModel.isValid(password: passwordConfirmationTextField.text)
            } else if textField == passwordConfirmationTextField {
                authenticationButton.isEnabled = viewModel.isValid(password: newText) && viewModel.isValid(email: usernameTextField.text) && viewModel.isValid(password: passwordTextField.text) && newText == passwordTextField.text
            }        
        }
        
        
        return true
    }
    
}

// MARK: - AuthenticationViewController (Keyboard avoidance)

private extension AuthenticationViewController {
    
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
        
        print("toggle keyboard with notification: \(notification)")
        
        let animationDuration = notification.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
        let animationCurve = notification.userInfo![UIResponder.keyboardAnimationCurveUserInfoKey] as! UInt
        let currentFrame = (notification.userInfo![UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        let targetFrame = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let deltaY = targetFrame.origin.y - currentFrame.origin.y
        
        updateLayout(deltaY: deltaY, animationDuration: animationDuration, animationCurve: animationCurve)
    }
    
    func updateLayout(deltaY: CGFloat, animationDuration: Double, animationCurve: UInt) {
        if deltaY < 0
            && signInContainerViewVCenterConstraint.constant == signInContainerViewVCenterConstraintConstant
            && changeStateStackBottomConstraint.constant == changeStateStackBottomConstraintConstant {
            // Keyboard is being shown
            // Center sign in stack view in the available vertical space (view.height - kb.heaight)
            let boundsUncoveredByKb = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height + deltaY)
            let targetSignInContainerViewVCenterConstraintConstant = boundsUncoveredByKb.height / 2 - view.bounds.height / 2
            signInContainerViewVCenterConstraint.constant = targetSignInContainerViewVCenterConstraintConstant
            
            // Center change state stack in the available vertical space between the sign in stack view bottom and the top of the keyboard
            let signInContainerTargetBottom = boundsUncoveredByKb.height / 2 + signInContainerView.bounds.height / 2
            let verticalSpaceAvailable = view.frame.height - abs(deltaY) - signInContainerTargetBottom
            let targetChangeStateStackBottomConstraintContant = abs(deltaY) + (verticalSpaceAvailable - changeStateContainerView.bounds.height) / 2 - view.safeAreaInsets.bottom
            changeStateStackBottomConstraint.constant = targetChangeStateStackBottomConstraintContant
        } else if deltaY > 0 {
            // TODO: Remove temporary hack for keyboard resizing (caused by attempt to show suggested strong pass)
            if deltaY < 20 {
                return
            }
            // Keyboard is being dismissed
            // Restore default positions
            signInContainerViewVCenterConstraint.constant = signInContainerViewVCenterConstraintConstant
            changeStateStackBottomConstraint.constant = changeStateStackBottomConstraintConstant
        } else {
            // Keyboard position has not changed (deltaY == 0), so we do nothing
            return
        }
                
        UIView.animate(withDuration: animationDuration, delay: 0, options: UIView.AnimationOptions(rawValue: animationCurve), animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    func resetInputs() {
        usernameTextField.text = ""
        usernameTextField.validationState = .isValid
        passwordTextField.text = ""
        passwordTextField.validationState = .isValid
        passwordConfirmationTextField.text = ""
        passwordConfirmationTextField.validationState = .isValid
        
        usernameTextField.becomeFirstResponder()
    }
}
