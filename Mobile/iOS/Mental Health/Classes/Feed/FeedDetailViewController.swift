//
//  FeedDetailViewController.swift
//  Mental Health
//
//  Created by Florin Voicu on 3/28/20.
//  Copyright © 2020 Mihai Betej. All rights reserved.
//

import UIKit

class FeedDetailViewController: UIViewController {
    struct FeedDetail {
        let title: String
        let image: UIImage
        let text: String
    }
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var textView: UITextView!
    
    var feedDetail: FeedDetail?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
//        titleLabel.text = feedDetail?.title
//        imageView.image = feedDetail?.image
//        textView.text = feedDetail?.text
    }
}
