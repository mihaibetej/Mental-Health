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
        answerSlider.delegate = self
        positionHintLabels()
    }
    
}

// MARK: - QuestionTableViewCell(MHSliderDelegate)

extension QuestionTableViewCell: MHSliderDelegate {
    
    func didSelect(step: Int) {
        print("step selected: \(step)")
    }
    
}

// MARK: - QuestionTableViewCell(private API)

private extension QuestionTableViewCell {
    
    func positionHintLabels() {
        let labelHint2CenterX = answerSlider.markerCenter(for: 1) + answerSlider.frame.minX
        let labelHint4CenterX = answerSlider.markerCenter(for: 3) + answerSlider.frame.minX
        
        let labelPosition2RightConstraintConstant =  (labelPosition3.frame.midX - labelHint2CenterX) - (labelPosition2.bounds.width / 2 + labelPosition3.bounds.width / 2)
        let labelPosition4LeftConstraintConstant = (labelHint4CenterX - labelPosition3.frame.midX) - (labelPosition4.bounds.width / 2 + labelPosition3.bounds.width / 2)
        
        guard labelPosition2RightConstraint.constant != labelPosition2RightConstraintConstant && labelPosition4LeftConstraint.constant != labelPosition4LeftConstraintConstant else {
            return
        }
        
        labelPosition2RightConstraint.constant = labelPosition2RightConstraintConstant
        labelPosition4LeftConstraint.constant = labelPosition4LeftConstraintConstant
    }
    
}
