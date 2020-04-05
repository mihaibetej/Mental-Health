//
//  QuestionnaireResultsViewController.swift
//  Mental Health
//
//  Created by Mihai Betej on 05/04/2020.
//  Copyright © 2020 Mihai Betej. All rights reserved.
//

import UIKit

// MARK: - QuestionnaireResultsViewController

class QuestionnaireResultsViewController: UIViewController {

    @IBOutlet weak var containerView: UIStackView!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var recommendationLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var phoneNumberButton: UIButton!
    @IBOutlet weak var emailContactLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailButton: UIButton!
    
    lazy var viewModel = QuestionnaireResultsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Închide", style: .plain, target: self, action: #selector(close))
        customize()
    }
    
    @IBAction func telephone(_ sender: Any) {
        telephone()
    }
    
    @IBAction func email(_ sender: Any) {
        composeEmail()
    }
    
}

// MARK: - QuestionnaireResultsViewController (private API)

private extension QuestionnaireResultsViewController {
    
    func customize() {
        // Title
        title = "Rezultate chestionar"
        
        // Controls appearance
        resultLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        recommendationLabel.font = UIFont.systemFont(ofSize: 28, weight: .light)
        recommendationLabel.textColor = .mhRecommendation
        phoneNumberLabel.font = UIFont.systemFont(ofSize: 18, weight: .light)
        phoneNumberButton.titleLabel?.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        phoneNumberButton.setTitleColor(.mhBlue, for: .normal)
        emailContactLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        emailLabel.font = UIFont.systemFont(ofSize: 18, weight: .light)
        emailButton.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        emailButton.setTitleColor(.mhBlue, for: .normal)
        
        // Stack spacing
        containerView.setCustomSpacing(0, after: phoneNumberLabel)
        containerView.setCustomSpacing(28, after: emailContactLabel)
        containerView.setCustomSpacing(0, after: emailLabel)
        
        // Content
        let resultText = NSMutableAttributedString(string: viewModel.resultsText)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 6 // Whatever line spacing you want in points
        resultText.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, resultText.length))
        resultLabel.attributedText = resultText

    }
    
    func composeEmail() {
        
    }
    
    func telephone() {
        
    }
    
    @objc func close() {
        dismiss(animated: true, completion: nil)
    }
    
}
