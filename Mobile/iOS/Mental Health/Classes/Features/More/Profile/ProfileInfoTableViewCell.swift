//
//  ProfileInfoTableViewCell.swift
//  Mental Health
//
//  Created by Florin Voicu on 4/1/20.
//  Copyright © 2020 Mihai Betej. All rights reserved.
//

import UIKit

class ProfileInfoTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueTextField: UITextField!
    
    func configure(title: String, value: String) {
        titleLabel.text = title
        valueTextField.text = value
    }
    
    func enterEditMode() {
        valueTextField.isEnabled = true
    }
    
    func exitEditMode() {
        valueTextField.isEnabled = false
        valueTextField.resignFirstResponder()
    }
}
