//
//  SendAnswersTableViewCell.swift
//  Mental Health
//
//  Created by Mihai Betej on 31/03/2020.
//  Copyright © 2020 Mihai Betej. All rights reserved.
//

import UIKit

// MARK: - SendAnswersTableViewCell

class SendAnswersTableViewCell: UITableViewCell {

    // MARK: Variables
    
    @IBOutlet weak var answerButton: MHButton!
    
    private weak var viewModel: QuestionnaireViewModel?
        
    // MARK: Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: Public API

    func configure(viewModel: QuestionnaireViewModel) {
        self.viewModel = viewModel
    }
    
    @IBAction func answerAction(_ sender: Any) {
        viewModel?.sendResults()
    }
    
}
