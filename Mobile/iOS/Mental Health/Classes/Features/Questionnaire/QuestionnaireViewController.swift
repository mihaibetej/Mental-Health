//
//  QuestionnaireViewController.swift
//  Mental Health
//
//  Created by Mihai Betej on 27/03/2020.
//  Copyright © 2020 Mihai Betej. All rights reserved.
//

import UIKit
import IHProgressHUD

// MARK: - QuestionnaireViewController

class QuestionnaireViewController: UIViewController {
    // MARK: Variables
    @IBOutlet weak var tableView: UITableView!
    
    private lazy var viewModel: QuestionnaireViewModel = {
        let viewModel = QuestionnaireViewModel(delegate: self)
        return viewModel
    }()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Chestionar" 
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // this needs to be here fo accurate slider hint labels layout
        tableView.reloadData()
    }
    
}

// MARK: - QuestionnaireViewController (QuestionnaireViewModelDelegate)

extension QuestionnaireViewController: QuestionnaireViewModelDelegate {
    
    // MARK: Loading
    
    func willUpdate() {
        IHProgressHUD.show()
    }
    
    func didUpdate() {
        tableView.reloadData()
        IHProgressHUD.dismiss()
    }
    
    func didFailToUpdate(with error: Error) {
        IHProgressHUD.dismiss()
        IHProgressHUD.showError(withStatus: ((error as NSError).userInfo["message"] as! String))
    }
    
    // MARK: Send results
    
    func willSendResults() {
        IHProgressHUD.set(defaultMaskType: .black)
        IHProgressHUD.show()
    }
    
    func didSendResults() {
        IHProgressHUD.dismiss()
        IHProgressHUD.set(defaultMaskType: .none)
        let questionnaireStoryboard = UIStoryboard(name: "Questionnaire", bundle: nil)
        let resultsNavC = questionnaireStoryboard.instantiateViewController(withIdentifier: "QuestionnaireResultsNavigationController") as! UINavigationController
        let resultsVC = resultsNavC.viewControllers.first! as! QuestionnaireResultsViewController
        resultsVC.viewModel.score = viewModel.score
        
        
        present(resultsNavC, animated: true, completion: nil)
    }
    
    func didFailToSendResults(with error: Error) {
        IHProgressHUD.dismiss()
        IHProgressHUD.set(defaultMaskType: .none)
        IHProgressHUD.showError(withStatus: ((error as NSError).userInfo["message"] as! String))
    }
}

// MARK: - QuestionnaireViewController (UITableViewDataSource, UITableViewDelegate)

extension QuestionnaireViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0..<viewModel.numberOfRows - 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionTableViewCell", for: indexPath) as! QuestionTableViewCell
            cell.configure(viewModel: viewModel, index: indexPath.row)            
            return cell
        case viewModel.numberOfRows - 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SendAnswersTableViewCell", for: indexPath) as! SendAnswersTableViewCell
            cell.configure(viewModel: viewModel)
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard viewModel.numberOfRows > 0 else {
            return nil
        }
        
        var headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header")
        if headerView == nil {
            headerView = UITableViewHeaderFooterView(reuseIdentifier: "header")
            if #available(iOS 13.0, *) {
                headerView?.contentView.backgroundColor = .systemBackground
            } else {
                headerView?.contentView.backgroundColor = .white
            }
        }
        
        // Create and configure label properties
        let titleLabel = UILabel(frame: headerView!.bounds)
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.semibold)
        titleLabel.backgroundColor = .clear
        if #available(iOS 13.0, *) {
            titleLabel.textColor = .label
        } else {
            titleLabel.textColor = .black
        }
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        // Configure label paragraph
        let attributedString = NSMutableAttributedString(string: "Vrem sa te ajutam sa iti fie mai bine!\nRaspunde chestionarului de mai jos si lasa-ne sa o facem!")
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 6 // Whatever line spacing you want in points
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        titleLabel.attributedText = attributedString
        
        // Add label and constraints
        headerView!.contentView.addSubview(titleLabel)
        let constraints = [
            titleLabel.topAnchor.constraint(equalTo: headerView!.contentView.topAnchor, constant: 20),
            titleLabel.leftAnchor.constraint(equalTo: headerView!.contentView.leftAnchor, constant: 16),
            titleLabel.bottomAnchor.constraint(equalTo: headerView!.contentView.bottomAnchor, constant: -20),
            titleLabel.rightAnchor.constraint(equalTo: headerView!.contentView.rightAnchor, constant: -16)
        ]
        NSLayoutConstraint.activate(constraints)
        
        return headerView!
    }
    
    // MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard viewModel.numberOfRows > 0 else {
            return 0
        }
        
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        guard viewModel.numberOfRows > 0 else {
            return 0
        }
        
        return 240
    }
    
}
