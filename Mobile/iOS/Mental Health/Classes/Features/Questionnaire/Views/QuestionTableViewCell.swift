//
//  QuestionTableViewCell.swift
//  Mental Health
//
//  Created by Mihai Betej on 28/03/2020.
//  Copyright © 2020 Mihai Betej. All rights reserved.
//

import UIKit

// MARK: - AnswerDelegate

protocol AnswerDelegate: class {
    func answerUpdated(for cell: QuestionTableViewCell)
}

// MARK: - QuestionTableViewCell

class QuestionTableViewCell: UITableViewCell {
    // Question container
    @IBOutlet weak var questionLabel: UILabel!
    // Hint labels
    @IBOutlet weak var labelPosition1: UILabel!
    @IBOutlet weak var labelPosition2: UILabel!
    @IBOutlet weak var labelPosition3: UILabel!
    @IBOutlet weak var labelPosition4: UILabel!
    @IBOutlet weak var labelPosition5: UILabel!
    // Hint label constraints
    @IBOutlet weak var labelPosition2RightConstraint: NSLayoutConstraint!
    @IBOutlet weak var labelPosition4LeftConstraint: NSLayoutConstraint!
    // Answer slider
    @IBOutlet weak var answerSlider: MHSlider!
        
    private weak var delegate: AnswerDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        labelPosition1.text = "Foarte mult"
        labelPosition2.text = "Mult"
        labelPosition3.text = "Mediu"
        labelPosition4.text = "Rar"
        labelPosition5.text = "Deloc"
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        positionHintLabels()
    }
    
    func configure(delegate: AnswerDelegate) {
        self.delegate = delegate
        //positionHintLabels()
    }
    
}

// MARK: - QuestionTableViewCell(private API)

private extension QuestionTableViewCell {
    
    func positionHintLabels() {
        let labelPosition2RightConstraintConstant = answerSlider.segmentWidth - (labelPosition2.bounds.width / 2 + labelPosition3.bounds.width / 2)
        let labelPosition4LeftConstraintConstant = answerSlider.segmentWidth - (labelPosition4.bounds.width / 2 + labelPosition3.bounds.width / 2)
        
        guard labelPosition2RightConstraint.constant != labelPosition2RightConstraintConstant && labelPosition4LeftConstraint.constant != labelPosition4LeftConstraintConstant else {
            return
        }
        
        labelPosition2RightConstraint.constant = labelPosition2RightConstraintConstant
        labelPosition4LeftConstraint.constant = labelPosition4LeftConstraintConstant
        layoutIfNeeded()
        
        print("labelPosition2 ideal marker x: \(answerSlider.frame.minX + answerSlider.segmentWidth)")
        print("labelPosition2.frame.midX: \(labelPosition2.frame.midX)")
        print("labelPosition4 ideal marker x: \(answerSlider.frame.minX + answerSlider.segmentWidth * 3)")
        print("labelPosition4.frame.midX: \(labelPosition4.frame.midX)")
    }
    
}
