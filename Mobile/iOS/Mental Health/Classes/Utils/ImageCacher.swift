//
//  ImageCacher.swift
//  Mental Health
//
//  Created by Florin Voicu on 4/6/20.
//  Copyright © 2020 Mihai Betej. All rights reserved.
//

import Foundation
import UIKit

class ImageCacher {
    enum ImageCacherErrors: Error {
        case parsing
    }
    
    static let imageCache = NSCache<NSString, UIImage>()
    
    static func downloadImage(url: URL, completion: @escaping (_ image: UIImage?, _ error: Error? ) -> Void) {
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            completion(cachedImage, nil)
        } else {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    completion(nil, error)
                } else if let data = data, let image = UIImage(data: data) {
                    imageCache.setObject(image, forKey: url.absoluteString as NSString)
                    completion(image, nil)
                } else {
                    completion(nil, ImageCacherErrors.parsing)
                }
            }.resume()
        }
    }
}
