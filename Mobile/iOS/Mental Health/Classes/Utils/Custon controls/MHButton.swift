//
//  MHButton.swift
//  Mental Health
//
//  Created by Mihai Betej on 03/04/2020.
//  Copyright © 2020 Mihai Betej. All rights reserved.
//

import UIKit

// MARK: - MHButton

class MHButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        customize()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        customize()
    }
    
    func customize() {
        backgroundColor = .clear
        titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        setTitleColor(.white, for: .normal)
        setBackgroundImage(UIImage(color: .mhBlue), for: .normal)
        layer.masksToBounds = true
        layer.cornerRadius = 8
    }

    
}

