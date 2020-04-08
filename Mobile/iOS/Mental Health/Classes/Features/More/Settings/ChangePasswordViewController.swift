//
//  ChangePasswordViewController.swift
//  Mental Health
//
//  Created by Florin Voicu on 4/8/20.
//  Copyright © 2020 Mihai Betej. All rights reserved.
//

import UIKit
import Firebase
import IHProgressHUD

class ChangePasswordViewController: UIViewController {
    
    @IBOutlet var oldPasswordTextField: UITextField!
    @IBOutlet var newPasswordTextField: UITextField!
    @IBOutlet var confirmNewPasswordTextField: UITextField!
    @IBOutlet weak var firstElementTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var firstElementInBetweenConstraint: NSLayoutConstraint!
    @IBOutlet weak var secondElementInBetweenConstraint: NSLayoutConstraint!
    @IBOutlet weak var thirdElementInBetweenConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if UIScreen.main.sizeType == .iPhone5 {
            firstElementInBetweenConstraint.constant = 14
            secondElementInBetweenConstraint.constant = 14
            thirdElementInBetweenConstraint.constant = 14
        }
        
        registerForKeyboardNotifications()
    }
    
    deinit {
        unregisterForKeyboardNotifications()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK: - Actions
    @IBAction func changePassword(sender: UIButton) {
        var errorText = ""
        if newPasswordTextField.text != confirmNewPasswordTextField.text ||
            !isValid(password: newPasswordTextField.text) {
            errorText = "Noile parole introduse nu coincid sau au mai puţin de 5 caractere. Vă rugăm să le reintroduceţi."
        } else if newPasswordTextField.text == oldPasswordTextField.text {
            errorText = "Vechea şi noua parolă coincid. Vă rugăm să le reintroduceţi."
        }
        
        if errorText.count > 0 {
            newPasswordTextField.text = ""
            confirmNewPasswordTextField.text = ""
            let controller = UIAlertController(title: "", message: errorText, preferredStyle: .alert)
            controller.addAction(UIAlertAction(title: "Ok", style: .default))
            present(controller, animated: true)
            return
        }
        
        IHProgressHUD.set(defaultMaskType: .black)
        IHProgressHUD.show()
        Auth.auth().signIn(withEmail: InternalUser.email ?? "",
                           password: oldPasswordTextField.text ?? "") { [weak self] (result, error) in
                            if let error = error {
                                // User login failed
                                DispatchQueue.main.async {
                                    IHProgressHUD.dismiss()
                                    IHProgressHUD.set(defaultMaskType: .none)
                                    let controller = UIAlertController(title: "", message: "Schimbarea parolei a eşuat. Vă rugăm să verificaţi corectitudinea parolei vechi şi să reîncercaţi.", preferredStyle: .alert)
                                    controller.addAction(UIAlertAction(title: "Ok", style: .default))
                                    self?.present(controller, animated: true)
                                }
                                print("password change failed with error \(error)")
                            } else if result != nil {
                                // User logged in
                                Auth.auth().currentUser?.updatePassword(to: (self?.newPasswordTextField.text)!, completion: { [weak self] (error) in
                                    if let error = error {
                                        DispatchQueue.main.async {
                                            IHProgressHUD.dismiss()
                                            IHProgressHUD.set(defaultMaskType: .none)
                                            let controller = UIAlertController(title: "", message: "Schimbarea parolei a eşuat. Vă rugăm să reîncercaţi.", preferredStyle: .alert)
                                            controller.addAction(UIAlertAction(title: "Ok", style: .default))
                                            self?.present(controller, animated: true)
                                        }
                                        print("password change failed with error \(error)")
                                    } else {
                                        DispatchQueue.main.async {
                                            IHProgressHUD.dismiss()
                                            IHProgressHUD.set(defaultMaskType: .none)
                                            let controller = UIAlertController(title: "", message: "Schimbarea parolei a reuşit!", preferredStyle: .alert)
                                            controller.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
                                                self?.oldPasswordTextField.text = ""
                                                self?.newPasswordTextField.text = ""
                                                self?.confirmNewPasswordTextField.text = ""
                                            }))
                                            self?.present(controller, animated: true)
                                        }
                                    }
                                })
                            } else {
                                // shrug...
                            }
        }
    }
    
    func isValid(password: String?) -> Bool {
        return (password ?? "").count > 4
    }

}

// MARK: - Textfield delegate

extension ChangePasswordViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == newPasswordTextField {
            confirmNewPasswordTextField.becomeFirstResponder()
            return true
        } else if textField == oldPasswordTextField {
            newPasswordTextField.becomeFirstResponder()
            return true
        }
        textField.resignFirstResponder()
        
        return true
    }
}

// MARK: - Keyboard adjustments

extension ChangePasswordViewController {
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
        let targetFrame = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        updateLayout(targetFrame: targetFrame, animationDuration: animationDuration, animationCurve: animationCurve)
    }
    
    func updateLayout(targetFrame: CGRect, animationDuration: Double, animationCurve: UInt) {
        if targetFrame.minY >= view.bounds.height {
            // Keyboard is being dismissed
            if UIScreen.main.sizeType == .iPhone5 {
                firstElementTopConstraint.constant = 20
            }
        } else {
            if UIScreen.main.sizeType == .iPhone5 {
                firstElementTopConstraint.constant = 8
            }
        }
        
        UIView.animate(withDuration: animationDuration, delay: 0, options: UIView.AnimationOptions(rawValue: animationCurve), animations: {
            self.view.layoutIfNeeded()
        })
    }
}
