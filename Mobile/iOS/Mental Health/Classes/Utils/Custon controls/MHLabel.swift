//
//  MHLabel.swift
//  Mental Health
//
//  Created by Mihai Betej on 03/04/2020.
//  Copyright © 2020 Mihai Betej. All rights reserved.
//

import UIKit

class MHLabel: UILabel {
    
    override var text: String? {
        willSet {
            let transition = CATransition()
            transition.type = .fade
            transition.timingFunction = CAMediaTimingFunction(name: .easeOut)
            transition.duration = CATransaction.animationDuration()
            layer.add(transition, forKey: "TransitionAnimation")
        }
    }
    
}
