//
//  ExpandableListViewController.swift
//  Mental Health
//
//  Created by George Muntean on 30/03/2020.
//  Copyright © 2020 Mihai Betej. All rights reserved.
//

import UIKit

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
    
    var items: [ExpandableListItem] = []
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
        cell.backgroundColor = UIColor.clear
        cell.didUpdateSize = { [weak self] in
            self?.tableView.reloadData()
        }
        return cell
    }
    
}

extension ExpandableListViewController: AddToExpandableListViewControllerDelegate {
    func didAdd(title: String, text: String) {
        items.insert(.init(title: title, text: text), at: 0)
        tableView.reloadData()
    }
}