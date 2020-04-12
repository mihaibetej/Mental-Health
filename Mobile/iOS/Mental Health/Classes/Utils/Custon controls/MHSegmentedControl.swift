//
//  MHSegmentedControl.swift
//  Mental Health
//
//  Created by Mihai Betej on 13/04/2020.
//  Copyright © 2020 Mihai Betej. All rights reserved.
//

import UIKit

class MHSegmentedControl: UISegmentedControl {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customize()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        customize()
    }
    
}

private extension MHSegmentedControl {
    
    func customize() {
        // Border
//        layer.masksToBounds = true
//        layer.cornerRadius = 8
//        layer.borderWidth = 1
//        layer.borderColor = UIColor.mhBlue.cgColor
                                
        // Selectet segment
        if #available(iOS 13.0, *) {
            selectedSegmentTintColor = .mhBlue
            backgroundColor = .clear
        } else {
            tintColor = .mhBlue
        }
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        setTitleTextAttributes(titleTextAttributes, for: .selected)
    }

}
