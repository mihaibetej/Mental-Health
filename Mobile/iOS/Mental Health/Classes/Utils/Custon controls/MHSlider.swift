//
//  MHSlider.swift
//  Mental Health
//
//  Created by Mihai Betej on 28/03/2020.
//  Copyright © 2020 Mihai Betej. All rights reserved.
//

import UIKit

// MARK: - MHSlider

class MHSlider: UISlider {
    
    // Bar thickness
    @IBInspectable open var trackHeight: CGFloat = 2 {
        didSet {
            customizeAppearance()
            setNeedsDisplay()
        }
    }
    
    // If number of steps is not 0, our slider becomes a stepper
    @IBInspectable open var numberOfSteps: CGFloat = 0 {
        didSet {
            if numberOfSteps == 0 {
                isContinuous = true
                removeTarget(self, action: #selector(valueDidChange(for:)), for: UIControl.Event.valueChanged)
            } else {
                isContinuous = false
                addTarget(self, action: #selector(valueDidChange(for:)), for: UIControl.Event.valueChanged)
            }
        }
    }
    
    override open func trackRect(forBounds bounds: CGRect) -> CGRect {
        let defaultBounds = super.trackRect(forBounds: bounds)
        return CGRect(
            x: defaultBounds.origin.x,
            y: defaultBounds.origin.y + defaultBounds.size.height / 2 - trackHeight / 2,
            width: defaultBounds.size.width,
            height: trackHeight
        )
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customizeAppearance()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        customizeAppearance()
    }
        
}

// MARK: - MHSlider(private API)

private extension MHSlider {
    
    func customizeAppearance() {
        minimumTrackTintColor = .clear
        maximumTrackTintColor = .clear
        setMaximumTrackImage(UIImage(bounds: trackRect(forBounds: bounds), colors: [UIColor.red.cgColor, UIColor.green.cgColor]), for: .normal)
        setMinimumTrackImage(UIImage(bounds: trackRect(forBounds: bounds), colors: [UIColor.red.cgColor, UIColor.green.cgColor]), for: .normal)
    }
    
    @objc func valueDidChange(for slider: UISlider) {
        guard numberOfSteps > 1 else {
            return
        }
        
        let interval = Float(1.0) / Float(numberOfSteps - 1)
        let step = slider.value / interval
        let wholeStep = roundf(step)
        slider.value = wholeStep * interval
    }
    
}
