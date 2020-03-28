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
    
    func configure(title: String, image: UIImage) {
        newsTitleLabel.text = title
        newsImageView.image = image

    }

}
