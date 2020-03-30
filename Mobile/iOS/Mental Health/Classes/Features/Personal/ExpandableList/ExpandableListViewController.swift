//
//  ExpandableListViewController.swift
//  Mental Health
//
//  Created by George Muntean on 30/03/2020.
//  Copyright © 2020 Mihai Betej. All rights reserved.
//

import UIKit

class ExpandableListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    var items: [ExpandableListItem] = []
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
        cell.didUpdateSize = { [weak self] in
            self?.tableView.reloadData()
        }
        return cell
    }
    
}
