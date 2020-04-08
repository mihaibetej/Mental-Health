//
//  SettingsViewController.swift
//  Mental Health
//
//  Created by Florin Voicu on 4/1/20.
//  Copyright © 2020 Mihai Betej. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    // MARK: Variables
    
    let cellIdentifier = "MoreCellIdentifier"
    
    enum Screen: String {
        case password
        
        var title: String {
            switch self {
            case .password:
                return "Modificare parolă"
            }
        }
        
        var segueIdentifier: String {
            return "goTo\(rawValue.capitalized)"
        }
        
        static let all: [Screen] = [.password]
    }
    
    @IBOutlet var tableView: UITableView!

    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableView.tableFooterView = UIView(frame: .zero)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}

// MARK: - MoreViewController (UITableViewDelegate, UITableViewDataSource)

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Screen.all.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : UITableViewCell!
        cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellIdentifier)
        }
        
        cell.textLabel?.text = Screen.all[indexPath.row].title
        cell.textLabel?.font = .systemFont(ofSize: 22, weight: .light)
        cell.accessoryType = .disclosureIndicator
        cell.accessoryView = SwiftDisclosureIndicator(frame: CGRect(x: 0, y: 0, width: 16, height: 24))
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //extract selectedDetails from model
        performSegue(withIdentifier: Screen.all[indexPath.row].segueIdentifier, sender: self)
    }
}
