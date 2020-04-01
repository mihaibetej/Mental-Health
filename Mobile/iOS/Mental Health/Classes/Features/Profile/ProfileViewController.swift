//
//  ProfileViewController.swift
//  Mental Health
//
//  Created by Florin Voicu on 4/1/20.
//  Copyright © 2020 Mihai Betej. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    struct Model {
        let title: String
        let value: String
    }
    var inEditMode = false
    
    var models = [Model(title: "Oras", value: "Bucuresti"),
                  Model(title: "Spital", value: "Universitar"),
                  Model(title: "Profesie", value: "Medic generalist"),
                  Model(title: "Telefon", value: "0700 000 000")]
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var profileImageViewContainer: UIView!
    @IBOutlet var nameLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.tableFooterView = UIView(frame: .zero)
        
        profileImageView.layer.borderColor = UIColor(named: "MHDarkBlue")?.cgColor
        profileImageView.layer.borderWidth = 1
        profileImageView.layer.cornerRadius = 50
        profileImageViewContainer.layer.shadowColor = UIColor.black.cgColor
        profileImageViewContainer.layer.shadowOpacity = 0.6
        profileImageViewContainer.layer.shadowOffset = CGSize.zero
        profileImageViewContainer.layer.masksToBounds = false
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func editDetails(sender: UIButton) {
        inEditMode = !inEditMode
        for case let cell as ProfileInfoTableViewCell in tableView.visibleCells {
            if inEditMode {
                cell.enterEditMode()
            } else {
                cell.exitEditMode()
            }
        }
    }

}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileInfoTableViewCell") as? ProfileInfoTableViewCell else {
            return ProfileInfoTableViewCell()
        }
        
        let model = models[indexPath.row]
        cell.configure(title: model.title, value: model.value)
        
        inEditMode ? cell.enterEditMode() : cell.exitEditMode()
        
        return cell
    }
}
