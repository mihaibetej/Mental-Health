//
//  SwiftDisclosureIndicator.swift
//  Mental Health
//
//  Created by Florin Voicu on 4/1/20.
//  Copyright © 2020 Mihai Betej. All rights reserved.
//

import UIKit

class SwiftDisclosureIndicator: UIView {
    var color = UIColor(named: "MHDarkBlue") ?? UIColor.blue
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        
        setNeedsDisplay()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        
        let x = self.bounds.maxX - 3
        let y = self.bounds.midY
        let R = CGFloat(7)
        context?.move(to: CGPoint(x: x - R, y: y - R))
        context?.addLine(to: CGPoint(x: x, y: y))
        context?.addLine(to: CGPoint(x: x - R, y: y + R))
        context?.setLineCap(.square)
        context?.setLineJoin(.miter)
        context?.setLineWidth(3)
        color.setStroke()
        context?.strokePath()
    }
}
