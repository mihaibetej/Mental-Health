//
//  QuestionnaireViewController.swift
//  Mental Health
//
//  Created by Mihai Betej on 27/03/2020.
//  Copyright © 2020 Mihai Betej. All rights reserved.
//

import UIKit

// MARK: - QuestionnaireViewController

class QuestionnaireViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private lazy var viewModel = QuestionnaireViewModel()
    
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
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header")
        if headerView == nil {
            headerView = UITableViewHeaderFooterView(reuseIdentifier: "header")
            headerView?.contentView.backgroundColor = .white
        }
        
        let titleLabel = UILabel(frame: headerView!.bounds)
        titleLabel.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.medium)
        titleLabel.backgroundColor = .clear
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 0
        titleLabel.text = "Vrem sa te ajutam sa iti fie mai bine!\nRaspunde chestionarului de mai jos si lasa-ne sa o facem!"
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        headerView!.contentView.addSubview(titleLabel)
        
        let constraints = [
            titleLabel.topAnchor.constraint(equalTo: headerView!.contentView.topAnchor, constant: 20),
            titleLabel.leftAnchor.constraint(equalTo: headerView!.contentView.leftAnchor, constant: 16),
            titleLabel.bottomAnchor.constraint(equalTo: headerView!.contentView.bottomAnchor, constant: -12),
            titleLabel.rightAnchor.constraint(equalTo: headerView!.contentView.rightAnchor, constant: -16)
        ]

        NSLayoutConstraint.activate(constraints)
        
        return headerView!
    }
    
    // MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 240
    }
    
}
