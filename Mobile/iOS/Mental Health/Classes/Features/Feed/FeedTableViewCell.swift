//
//  FeedTableViewCell.swift
//  Mental Health
//
//  Created by Florin Voicu on 3/28/20.
//  Copyright © 2020 Mihai Betej. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell {
    
    @IBOutlet var newsTitleLabel: UILabel!
    @IBOutlet var newsImageView: UIImageView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var noImageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        newsImageView.layer.shadowColor = UIColor.black.cgColor
        newsImageView.layer.shadowOpacity = 0.8
        newsImageView.layer.shadowOffset = CGSize.zero
        newsImageView.layer.shadowRadius = 8
        newsImageView.layer.masksToBounds = false
    }
    
    func configure(title: String, imageURL: URL?) {
        newsTitleLabel.text = title
        newsImageView.image = nil
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        noImageLabel.isHidden = true
        
        guard let url = imageURL else {
            newsImageView.image = nil
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
                self?.newsImageView.image = image
                self?.activityIndicator.stopAnimating()
                self?.activityIndicator.isHidden = true
            }
        }

    }
}
