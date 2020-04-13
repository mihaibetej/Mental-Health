//
//  ExpandableListViewController.swift
//  Mental Health
//
//  Created by George Muntean on 30/03/2020.
//  Copyright © 2020 Mihai Betej. All rights reserved.
//

import UIKit
import IHProgressHUD

class ExpandableListViewController: UIViewController {
    
    struct Config {
        let allowsAdding: Bool
    }

    struct Segues {
        static let addToList = "embedAddToList"
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    var config: Config?
    var viewModel: ExpandableListViewModel!
    
    // MARK: - Life Cylce
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if config?.allowsAdding != true {
            tableView.tableHeaderView = nil
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as? AddToExpandableListViewController
        switch segue.identifier {
        case Segues.addToList:
            destination?.delegate = self
        default:
            break
        }
    }
}

// MARK: - Table View Data Source

extension ExpandableListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ExpandableListCell
        
        guard let item = viewModel.item(for: indexPath.row) else {
            preconditionFailure()
        }
        
        cell.titleLabel.text = item.title
        cell.detailsLabel.text = item.text
        
        let textHeight = item.text.heightWithConstrainedWidth(width: view.bounds.width - 40.0, font: cell.detailsLabel.font)
        
        cell.moreButton.isHidden = true
        if textHeight > cell.detailsLabel.font.pointSize * 4 {
            cell.moreButton.isHidden = false
        }
        
        cell.backgroundColor = UIColor.clear
        cell.didUpdateSize = { [weak self] in
            self?.tableView.reloadData()
        }
        return cell
    }
    
}

// MARK: - AddToExpandableListViewControllerDelegate

extension ExpandableListViewController: AddToExpandableListViewControllerDelegate {
    func didAdd(title: String, text: String) {
        viewModel.addData(title: title, text: text)
    }
}

// MARK: - ExpandableListViewModelDelegate

extension ExpandableListViewController: ExpandableListViewModelDelegate {
    func willUpdate() {
        IHProgressHUD.show()
    }
    
    func didUpdate() {
        IHProgressHUD.dismiss()
        tableView.reloadData()
    }
    
    func didFailToUpdate(with error: Error) {
        IHProgressHUD.dismiss()
        IHProgressHUD.showError(withStatus: ((error as NSError).userInfo["message"] as! String))
        tableView.reloadData()
    }
}
