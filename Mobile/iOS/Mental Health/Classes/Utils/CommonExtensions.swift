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
    
    convenience init?(bounds: CGRect, colors: [CGColor], offset: CGFloat = 0.0) {
        let layer = CAGradientLayer()
        layer.cornerRadius = bounds.height/2.0
        layer.frame = CGRect(x: bounds.minX, y: bounds.minY, width: bounds.width - offset, height: bounds.height)
        layer.colors = colors
        layer.endPoint = CGPoint(x: 1.0, y:  1.0)
        layer.startPoint = CGPoint(x: 0.0, y:  1.0)

        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, 0.0)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let layerImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = layerImage?.resizableImage(withCapInsets: .zero).cgImage else {
            return nil
        }
        
        self.init(cgImage: cgImage)
    }
        
}
