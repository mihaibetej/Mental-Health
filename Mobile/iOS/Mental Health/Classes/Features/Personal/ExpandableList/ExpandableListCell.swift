//
//  ExpandableListCell.swift
//  Mental Health
//
//  Created by George Muntean on 30/03/2020.
//  Copyright © 2020 Mihai Betej. All rights reserved.
//

import UIKit

class ExpandableListCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var moreButton: UIButton!
    
    var didUpdateSize: (()->())?
    
    var isExpanded = false {
        didSet {
            if isExpanded == true {
                moreButton.setTitle("Mai putin...", for: .normal)
                detailsLabel.numberOfLines = 0
            } else {
                moreButton.setTitle("Mai mult...", for: .normal)
                detailsLabel.numberOfLines = 4
            }
        }
    }

    @IBAction func moreButtonTap(_ sender: UIButton) {
        isExpanded = !isExpanded
        didUpdateSize?()
    }
}
