//
//  FeedDetailViewController.swift
//  Mental Health
//
//  Created by Florin Voicu on 3/28/20.
//  Copyright © 2020 Mihai Betej. All rights reserved.
//

import UIKit

class FeedDetailViewController: UIViewController {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var textView: UITextView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var noImageLabel: UILabel!
    
    var feedDetail: NewsItem?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOpacity = 0.8
        imageView.layer.shadowOffset = CGSize.zero
        imageView.layer.shadowRadius = 8
        imageView.layer.masksToBounds = false
        
        titleLabel.text = feedDetail?.title
        textView.text = feedDetail?.body
        
        imageView.image = nil
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        noImageLabel.isHidden = true
        
        guard let urlString = feedDetail?.image,
            let url = URL(string: urlString) else {
            imageView.image = nil
            activityIndicator.stopAnimating()
            activityIndicator.isHidden = true
            noImageLabel.isHidden = false
            return
        }
        
        ImageCacher.downloadImage(url: url) { [weak self] (image, error) in
            guard let image = image else {
                print("failed to load image with error: \(String(describing: error))")
                DispatchQueue.main.async {
                    self?.activityIndicator.stopAnimating()
                    self?.activityIndicator.isHidden = true
                    self?.noImageLabel.isHidden = false
                }
                return
            }
            
            DispatchQueue.main.async {
                self?.imageView.image = image
                self?.activityIndicator.stopAnimating()
                self?.activityIndicator.isHidden = true
            }
        }
    }
}
