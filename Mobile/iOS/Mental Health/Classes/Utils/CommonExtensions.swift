//
//  CommonExtensions.swift
//  Mental Health
//
//  Created by Mihai Betej on 28/03/2020.
//  Copyright © 2020 Mihai Betej. All rights reserved.
//

import UIKit

// MARK: UIImage

extension UIImage {
    
    
    /// Creates a rounded corner gradient image
    /// - Parameter bounds: Used to determine image size
    /// - Parameter colors: The gradients
    /// - Parameter offset: image width offset
    convenience init?(bounds: CGRect, colors: [CGColor], offset: CGFloat = 0.0) {
        // Create gradient layer
        let layer = CAGradientLayer()
        layer.cornerRadius = bounds.height / 2.0
        layer.frame = CGRect(x: bounds.minX,
                             y: bounds.minY,
                             width: bounds.width - offset,
                             height: bounds.height)
        layer.colors = colors
        layer.endPoint = CGPoint(x: 1.0, y:  1.0)
        layer.startPoint = CGPoint(x: 0.0, y:  1.0)

        // Draw layer in current context
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, 0.0)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let layerImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // Extract image
        guard let cgImage = layerImage?.resizableImage(withCapInsets: .zero).cgImage else {
            return nil
        }
        
        self.init(cgImage: cgImage)
    }
        
}

extension UIColor {
    static let mhBlue = #colorLiteral(red: 0.1294117647, green: 0.4901960784, blue: 0.7921568627, alpha: 1)
}
