//
//  MoreViewController.swift
//  Mental Health
//
//  Created by Mihai Betej on 27/03/2020.
//  Copyright © 2020 Mihai Betej. All rights reserved.
//

import UIKit

class MoreViewController: UIViewController {
    
    let cellIdentifier = "MoreCellIdentifier"
    
    enum Screen: String {
        case profile
        case journal
        case settings
        case contact
        
        var title: String {
            switch self {
            case .profile:
                return "Profil"
            case .journal:
                return "Jurnal personal"
            case .settings:
                return "Setări"
            case .contact:
                return "Contact"
            }
        }
        
        var segueIdentifier: String {
            return "goTo\(rawValue.capitalized)"
        }
        
        static let all: [Screen] = [.profile, .journal, .settings, .contact]
    }
    
    @IBOutlet var tableView: UITableView!

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
        cell.textLabel?.font = .systemFont(ofSize: 24, weight: .light)
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
