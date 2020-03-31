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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        newsImageView.layer.shadowColor = UIColor.black.cgColor
        newsImageView.layer.shadowOpacity = 0.4
        newsImageView.layer.shadowOffset = CGSize.zero
        newsImageView.layer.shadowRadius = 8
        newsImageView.layer.masksToBounds = false
    }
    
    func configure(title: String, image: UIImage) {
        newsTitleLabel.text = title
        newsImageView.image = image

    }

}
