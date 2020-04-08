//
//  MHTextField.swift
//  Mental Health
//
//  Created by Mihai Betej on 03/04/2020.
//  Copyright © 2020 Mihai Betej. All rights reserved.
//

import UIKit

// MARK: - MHTextField

class MHTextField: UITextField {
    
    enum ValidationState {
        case isValid
        case isInvalid
    }
    
    var validationState: ValidationState = .isValid {
        didSet {
            switch validationState {
            case .isValid:
                customizeForValidState()
            case .isInvalid:
                customizeForInvalidState()
            }
        }
    }
    
    override var isEnabled: Bool {
        didSet {
            if self.isEnabled {
                layer.borderWidth = 1
            } else {
                layer.borderWidth = 0
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customize()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        customize()
    }

}

// MARK: - MHTextField (private API)

private extension MHTextField {
        
    func customize() {
        // Border
        layer.masksToBounds = true
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.borderColor = UIColor.mhBlue.cgColor
        
        // Text color
        // textColor = .mhBlue
        
        // Carret color
        tintColor = .mhBlue
        
        // Placeholder color
        // attributedPlaceholder
    }
    
    func customizeForValidState() {
        let transition = CATransition()
        transition.type = .fade
        transition.timingFunction = CAMediaTimingFunction(name: .easeOut)
        transition.duration = CATransaction.animationDuration()
        layer.add(transition, forKey: "StateChangeAnimation")
        backgroundColor = .white
        layer.borderColor = UIColor.mhBlue.cgColor
    }
    
    func customizeForInvalidState() {
        let transition = CATransition()
        transition.type = .fade
        transition.timingFunction = CAMediaTimingFunction(name: .easeOut)
        transition.duration = CATransaction.animationDuration()
        layer.add(transition, forKey: "StateChangeAnimation")
        backgroundColor = .mhTextInvalid
        layer.borderColor = UIColor.mhRed.cgColor
    }
    
}
