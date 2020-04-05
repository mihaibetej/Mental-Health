//
//  MoreViewController.swift
//  Mental Health
//
//  Created by Mihai Betej on 27/03/2020.
//  Copyright © 2020 Mihai Betej. All rights reserved.
//

import UIKit

// MARK: - MoreViewController

class MoreViewController: UIViewController {
    
    // MARK: Variables
    
    let cellIdentifier = "MoreCellIdentifier"
    
    enum Screen: String {
        case profile
        case journal
        case statistics
        case settings
        case contact
        
        var title: String {
            switch self {
            case .profile:
                return "Profil"
            case .journal:
                return "Jurnal eroului"
            case .statistics:
                return "Statistici"
            case .settings:
                return "Setări"
            case .contact:
                return "Contact"
            }
        }
        
        var segueIdentifier: String {
            return "goTo\(rawValue.capitalized)"
        }
        
        static let all: [Screen] = [.profile, .journal, .statistics, .settings, .contact]
    }
    
    @IBOutlet var tableView: UITableView!

    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableView.tableFooterView = UIView(frame: .zero)
    }
    

    // MARK: Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToContact" {
            guard let destVC = segue.destination as? QuestionnaireResultsViewController else {
                return
            }
            
            destVC.viewModel.title = "Contact"
        }
    }

}

// MARK: - MoreViewController (UITableViewDelegate, UITableViewDataSource)

extension MoreViewController: UITableViewDelegate, UITableViewDataSource {
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
