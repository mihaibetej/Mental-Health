//
//  QuestionnaireResultsViewController.swift
//  Mental Health
//
//  Created by Mihai Betej on 05/04/2020.
//  Copyright © 2020 Mihai Betej. All rights reserved.
//

import UIKit
import MessageUI
import IHProgressHUD

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

// MARK: - QuestionnaireResultsViewController (MFMailComposeViewControllerDelegate)

extension QuestionnaireResultsViewController: MFMailComposeViewControllerDelegate {
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        if let error = error {
            IHProgressHUD.showError(withStatus: error.localizedDescription)
        }
        
        controller.dismiss(animated: true, completion: nil)
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
        guard MFMailComposeViewController.canSendMail() == true else {
            IHProgressHUD.showError(withStatus: "Serviciul de email nu este disponibil!")
            return
        }
        
        let composeVC = MFMailComposeViewController()
        composeVC.mailComposeDelegate = self
         
        // Configure the fields of the interface.
        composeVC.setToRecipients([emailButton.titleLabel?.text ?? ""])
        composeVC.setSubject("4MedicAll")
         
        // Present the view controller modally.
        self.present(composeVC, animated: true, completion: nil)
        
        
    }
    
    func telephone() {
        guard let phone = phoneNumberButton.titleLabel?.text?.replacingOccurrences(of: " ", with: "") else {
            return
        }
        
        let phoneUrl = URL(string: "telprompt://\(phone)")
        let phoneFallbackUrl = URL(string: "tel://\(phone)")
        
        if(phoneUrl != nil && UIApplication.shared.canOpenURL(phoneUrl!)) {
            UIApplication.shared.open(phoneUrl!, options: [:]) { (success) in
                if !success {
                    // Show an error message: Failed opening the url
                    IHProgressHUD.showError(withStatus: "Plasarea apelului a esuat!")
                }
            }
        } else if(phoneFallbackUrl != nil && UIApplication.shared.canOpenURL(phoneFallbackUrl!)) {
            UIApplication.shared.open(phoneFallbackUrl!, options: [:]) { (success) in
                if !success {
                    // Show an error message: Failed opening the url
                    IHProgressHUD.showError(withStatus: "Plasarea apelului a esuat!")
                }
            }
        } else {
            // Show an error message: Your device can not do phone calls.
            IHProgressHUD.showError(withStatus: "Plasarea apelului a esuat!")
        }
    }
    
    @objc func close() {
        dismiss(animated: true, completion: nil)
    }
    
}
