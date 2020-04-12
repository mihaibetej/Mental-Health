//
//  HistoricalResultTableViewCell.swift
//  Mental Health
//
//  Created by Mihai Betej on 12/04/2020.
//  Copyright © 2020 Mihai Betej. All rights reserved.
//

import UIKit

class HistoricalResultTableViewCell: UITableViewCell {

    @IBOutlet weak var resultImageView: UIImageView!
    @IBOutlet weak var resultDateLabel: UILabel!
    @IBOutlet weak var resultsScoreLabel: UILabel!    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(viewModel: StatisticsViewModel, index: Int) {
        resultImageView.image = viewModel.resultImage(for: index)
        resultDateLabel.text = viewModel.resultDateReadable(for: index)
        resultsScoreLabel.text = viewModel.resultScoreReadable(for: index)
    }
    
}
