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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if config?.allowsAdding != true {
            tableView.tableHeaderView = nil
        }
    }
    
    var items: [ExpandableListItem] = [] {
        didSet {
            tableView.reloadData()
        }
    }
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

extension ExpandableListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ExpandableListCell
        let item = items[indexPath.row]
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

extension ExpandableListViewController: AddToExpandableListViewControllerDelegate {
    func didAdd(title: String, text: String) {
        
        InternalUser.getCurrent { user in
            guard let user = user else {
                IHProgressHUD.showError(withStatus: "Actiunea nu poate a putut fi executata")
                return
            }
            
            Session.shared.dataBase
                .collection("users")
                .document(user.internalUserId!)
                .collection("journals")
                .addDocument(data: ["date": Date(), "body": text]) { err in
                    if let _ = err {
                        
                    } else {
                        DispatchQueue.main.async {
                            self.items.insert(.init(title: title, text: text), at: 0)
                            self.tableView.reloadData()
                        }
                    }
            }
            
        }
    }
}
