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
    @IBInspectable open var numberOfSteps: Int = 0 {
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
    
    var segmentWidth: CGFloat {
        return numberOfSteps > 1 ? bounds.width / CGFloat(numberOfSteps - 1) : bounds.width
    }
        
    private var segmentMarkers: Int {
        return numberOfSteps > 2 ? numberOfSteps - 2 : 0
    }
    
    private struct Constants {
        static let segmentMarkerHeight: Int = 5
        static let segmentMarkerLineWidth: CGFloat = 1
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

// MARK: - MHSlider(Draw)

extension MHSlider {
    
    override func draw(_ rect: CGRect) {
        // Check if we have any markers to draw
        guard segmentMarkers > 0 else {
            return
        }
        
        let y = Int((rect.height - trackHeight) / 2) + 1
        for i in 1...segmentMarkers {
            let x = Int(CGFloat(i) * (rect.width / CGFloat(numberOfSteps - 1)))
            let path = UIBezierPath()
            path.lineWidth = Constants.segmentMarkerLineWidth
            path.move(to: CGPoint(x: x, y: y))
            path.addLine(to: CGPoint(x: x, y: y - Constants.segmentMarkerHeight))
            path.close()
            
            UIColor.black.set()
            path.stroke()
        }
    }
    
}

// MARK: - MHSlider(private API)

private extension MHSlider {
    
    func customizeAppearance() {
        minimumTrackTintColor = .clear
        maximumTrackTintColor = .clear
        
        let sliderGradientImage = UIImage(bounds: trackRect(forBounds: bounds), colors: [UIColor.red.cgColor, UIColor.green.cgColor])
        setMaximumTrackImage(sliderGradientImage, for: .normal)
        setMinimumTrackImage(sliderGradientImage, for: .normal)
    }
    
    @objc func valueDidChange(for slider: UISlider) {
        guard numberOfSteps > 1 else {
            return
        }
        
        let stepSegment = Float(1.0) / Float(numberOfSteps - 1)
        let step = slider.value / stepSegment
        let wholeStep = roundf(step)
        slider.value = wholeStep * stepSegment
    }
    
}
