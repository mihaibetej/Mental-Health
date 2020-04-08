//
//  ProfileInfoTableViewCell.swift
//  Mental Health
//
//  Created by Florin Voicu on 4/1/20.
//  Copyright © 2020 Mihai Betej. All rights reserved.
//

import UIKit

class ProfileInfoTableViewCell: UITableViewCell {
    struct EditModeOutput {
        let title: String
        let value: String?
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueTextField: UITextField!
    @IBOutlet weak var titleBottomConstraint: NSLayoutConstraint!
    
    func configure(title: String, value: String, placeholder: String) {
        titleLabel.text = title
        valueTextField.text = value
        valueTextField.placeholder = placeholder
        valueTextField.delegate = self
        if UIScreen.main.sizeType == .iPhone5 { titleBottomConstraint.constant = 3 }
    }
    
    func enterEditMode() {
        valueTextField.isEnabled = true
        valueTextField.borderStyle = .roundedRect
    }
    
    @discardableResult func exitEditMode() -> EditModeOutput {
        valueTextField.isEnabled = false
        valueTextField.borderStyle = .none
        valueTextField.resignFirstResponder()
        return EditModeOutput(title: titleLabel.text ?? "", value: valueTextField.text)
    }
}

extension ProfileInfoTableViewCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
