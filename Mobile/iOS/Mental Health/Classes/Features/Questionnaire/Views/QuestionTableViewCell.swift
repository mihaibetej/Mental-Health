//
//  QuestionTableViewCell.swift
//  Mental Health
//
//  Created by Mihai Betej on 28/03/2020.
//  Copyright © 2020 Mihai Betej. All rights reserved.
//

import UIKit

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
        
    private weak var viewModel: QuestionnaireViewModel!
    private var index: Int!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        questionLabel.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.light)
        labelPosition1.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.light)
        labelPosition1.text = "Foarte mult"
        labelPosition2.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.light)
        labelPosition2.text = "Mult"
        labelPosition3.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.light)
        labelPosition3.text = "Mediu"
        labelPosition4.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.light)
        labelPosition4.text = "Rar"
        labelPosition5.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.light)
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
    
    func configure(viewModel: QuestionnaireViewModel, index: Int) {
        self.viewModel = viewModel
        self.index = index
        
        answerSlider.delegate = self
        positionHintLabels()
                
        guard let question = viewModel.question(for: index) else {
            return
        }
        questionLabel.text = "\(question.index). \(question.text)"
        answerSlider.step = question.answer - 1
        updateHintLabelsVisibility(for: answerSlider.step)
    }
    
}

// MARK: - QuestionTableViewCell(MHSliderDelegate)

extension QuestionTableViewCell: MHSliderDelegate {
    
    func didBeginDragging() {
    }
    
    func stepValueChanged(value: Float) {
        guard floor(value) != value else {
            return
        }
        
        let minStep = value.rounded(.down)
        let maxStep = value.rounded(.up)
        
        let lowerAlpha = 1 - (min((value - minStep), 0.5) / 0.5)
        let upperAlpha = 1 - (min((maxStep - value), 0.5) / 0.5)
        
        switch minStep {
        case 0:
            labelPosition2.alpha = CGFloat(upperAlpha)
            labelPosition3.alpha = 0
            labelPosition4.alpha = 0
        case 1:
            labelPosition2.alpha = CGFloat(lowerAlpha)
            labelPosition3.alpha = CGFloat(upperAlpha)
            labelPosition4.alpha = 0
        case 2:
            labelPosition2.alpha = 0
            labelPosition3.alpha = CGFloat(lowerAlpha)
            labelPosition4.alpha = CGFloat(upperAlpha)
        case 3:
            labelPosition2.alpha = 0
            labelPosition3.alpha = 0
            labelPosition4.alpha = CGFloat(lowerAlpha)
        default:
            break
        }
    }
    
    func didSelect(step: Int) {
        print("step selected: \(step)")
        // Update view model
        viewModel.updateQuestion(at: index, with: step + 1)
        // Make sure final alpha is applied
        updateHintLabelsVisibility(for: step)
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
    
    func updateHintLabelsVisibility(for step: Int) {
        switch step {
        case 1:
            labelPosition2.alpha = 1
            labelPosition3.alpha = 0
            labelPosition4.alpha = 0
        case 2:
            labelPosition2.alpha = 0
            labelPosition3.alpha = 1
            labelPosition4.alpha = 0
        case 3:
            labelPosition2.alpha = 0
            labelPosition3.alpha = 0
            labelPosition4.alpha = 1
        default:
            break
        }
    }
    
}
