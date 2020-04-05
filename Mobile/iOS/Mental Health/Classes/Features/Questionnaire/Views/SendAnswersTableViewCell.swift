//
//  SendAnswersTableViewCell.swift
//  Mental Health
//
//  Created by Mihai Betej on 31/03/2020.
//  Copyright © 2020 Mihai Betej. All rights reserved.
//

import UIKit

protocol SendAnswersTableViewCellDelegate: class {
    func sendResults()
}

class SendAnswersTableViewCell: UITableViewCell {

    @IBOutlet weak var answerButton: MHButton!
    
    weak var delegate: SendAnswersTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(delegate: SendAnswersTableViewCellDelegate) {
        self.delegate = delegate
    }
    
    @IBAction func answerAction(_ sender: Any) {
        delegate?.sendResults()
    }
    
}
