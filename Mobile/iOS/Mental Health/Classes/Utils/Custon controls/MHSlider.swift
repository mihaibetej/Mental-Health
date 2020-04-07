//
//  MHSlider.swift
//  Mental Health
//
//  Created by Mihai Betej on 28/03/2020.
//  Copyright © 2020 Mihai Betej. All rights reserved.
//

import UIKit

// MARK: - MHSliderDelegate

protocol MHSliderDelegate: class {
    func didBeginDragging()
    func stepValueChanged(value: Float)
    func didSelect(step: Int)
}

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
                removeTarget(self, action: #selector(valueDidChange(for:event:)), for: UIControl.Event.valueChanged)
            } else {
                addTarget(self, action: #selector(valueDidChange(for:event:)), for: UIControl.Event.valueChanged)
            }
        }
    }
    
    weak var delegate: MHSliderDelegate?
    
    var segmentWidth: CGFloat {
        return numberOfSteps > 1 ? bounds.width / CGFloat(numberOfSteps - 1) : bounds.width
    }
    
    var step: Int {
        get {            
            return Int(roundf(stepCurrentValue))
        }
        set {
            value = Float(newValue) * stepValueSegment
        }
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
    
    // Since the slider thumb will not be centered on the edges of the slider, but rather be offset by width/2 there, we need to account for thet offset in the markers. The offset is 0 in the middle of the slider and gradually goes to +/- width/2 on the edges
    func markerCenter(for step: Int) -> CGFloat {
        guard numberOfSteps > 1 else {
            return 0
        }
        
        let thumbR = thumbRect(forBounds: bounds, trackRect: trackRect(forBounds: bounds), value: value(for: step))
        return thumbR.midX
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
            let x = Int(markerCenter(for: i))
            let path = UIBezierPath()
            path.lineWidth = Constants.segmentMarkerLineWidth
            path.move(to: CGPoint(x: x, y: y))
            path.addLine(to: CGPoint(x: x, y: y - Constants.segmentMarkerHeight))
            path.close()
            
            if #available(iOS 13.0, *) {
                UIColor.label.set()
            } else {
                UIColor.black.set()
            }            
            path.stroke()
        }
    }
    
}

// MARK: - MHSlider(private API)

private extension MHSlider {
    
    var stepValueSegment: Float {
        return Float(1.0) / Float(numberOfSteps - 1)
    }
    
    var stepCurrentValue: Float {
        return value / stepValueSegment
    }
    
    func customizeAppearance() {
        minimumTrackTintColor = .clear
        maximumTrackTintColor = .clear
        
        let startColor = UIColor.mhRed.cgColor
        let endColor = UIColor.mhGreen.cgColor
        let sliderGradientImage = UIImage(bounds: trackRect(forBounds: bounds), colors: [startColor, endColor])
        setMaximumTrackImage(sliderGradientImage, for: .normal)
        setMinimumTrackImage(sliderGradientImage, for: .normal)
    }
    
    @objc func valueDidChange(for slider: UISlider, event: UIEvent) {
        guard numberOfSteps > 1 else {
            return
        }
        
        if let touchEvent = event.allTouches?.first {
            switch touchEvent.phase {
            case .began, .stationary:
                delegate?.didBeginDragging()
            case .moved:
                // handle drag moved
                delegate?.stepValueChanged(value: stepCurrentValue)
                break
            case .ended, .cancelled:
                let wholeStep = roundf(stepCurrentValue)
                slider.value = wholeStep * stepValueSegment
                
                delegate?.didSelect(step: Int(wholeStep))
            default:
                break
            }
        }
    }

    func value(for step: Int) -> Float {
        guard numberOfSteps > 1 else {
            return 0
        }
        
        let stepSegment = Float(1.0) / Float(numberOfSteps - 1)
        return Float(step) * stepSegment
    }
    
}
