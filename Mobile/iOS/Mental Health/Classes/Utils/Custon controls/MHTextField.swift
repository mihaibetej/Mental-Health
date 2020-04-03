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
    }
    
}
