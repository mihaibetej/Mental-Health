//
//  ProfileViewController.swift
//  Mental Health
//
//  Created by Florin Voicu on 4/1/20.
//  Copyright © 2020 Mihai Betej. All rights reserved.
//

import UIKit
import FirebaseAuth

// MARK: - ProfileViewController

class ProfileViewController: UIViewController {
    
    struct Model {
        let title: String
        let placeholder: String
        let value: String
    }
    
    struct UserData {
        static let tableEntries = 4
        
        mutating func set(value: String?, for modelTitle: String) {
            switch modelTitle {
            case "Oraș":
                InternalUser.shared.town = value
            case "Spital":
                InternalUser.shared.hospital = value
            case "Profesie":
                InternalUser.shared.jobTitle = value
            case "Telefon":
                InternalUser.shared.phoneNo = value
            default:
                break
            }
        }
        
        func getTableModel(at row: Int) -> Model {
            switch row {
            case 0:
                return Model(title: "Oraș", placeholder: "", value: InternalUser.shared.town ?? "")
            case 1:
                return Model(title: "Spital", placeholder: "", value: InternalUser.shared.hospital ?? "")
            case 2:
                return Model(title: "Profesie", placeholder: "", value: InternalUser.shared.jobTitle ?? "")
            case 3:
                return Model(title: "Telefon", placeholder: "", value: InternalUser.shared.phoneNo ?? "")
                
            default:
                return Model(title: "", placeholder: "", value: "")
            }
        }
    }
    
    var userData = UserData()
    
    var inEditMode = false
        
    @IBOutlet var tableView: UITableView!
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var profileImageViewContainer: UIView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet weak var viewContainerTopConstraint: NSLayoutConstraint!
    
    
    private var currentUser: User? {
        return Auth.auth().currentUser
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.tableFooterView = UIView(frame: .zero)
        
        profileImageView.layer.borderColor = UIColor.mhBlue.cgColor
        profileImageView.layer.borderWidth = 1
        profileImageView.layer.cornerRadius = 50
        profileImageViewContainer.layer.shadowColor = UIColor.black.cgColor
        profileImageViewContainer.layer.shadowOpacity = 0.6
        profileImageViewContainer.layer.shadowOffset = CGSize.zero
        profileImageViewContainer.layer.masksToBounds = false
        
        nameLabel.text = currentUser?.email ?? "Ion Popescu"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Deconectare", style: UIBarButtonItem.Style.plain, target: self, action: #selector(signOut))
        
        fetchUserData()
        registerForKeyboardNotifications()
    }
        
    deinit {
        unregisterForKeyboardNotifications()
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
                let output = cell.exitEditMode()
                userData.set(value: output.value, for: output.title)
            }
        }
        
        if !inEditMode {
            saveUserData()
            UIView.performWithoutAnimation {
                sender.setTitle("Editare detalii", for: .normal)
            }
        } else {
            UIView.performWithoutAnimation {
                sender.setTitle("Salvează", for: .normal)
            }
        }
    }

}

// MARK: - ProfileViewController (UITableViewDelegate, UITableViewDataSource)

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch UIScreen.main.sizeType {
        case .iPhone5:
            return 73
        case .iPhone6:
            return 85
        default:
            return 100
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserData.tableEntries
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileInfoTableViewCell") as? ProfileInfoTableViewCell else {
            return ProfileInfoTableViewCell()
        }
        
        let model = userData.getTableModel(at: indexPath.row)
        cell.configure(title: model.title, value: model.value, placeholder: model.placeholder)
        
        if inEditMode {
            cell.enterEditMode()
        } else {
            cell.exitEditMode()
        }
        
        return cell
    }
}

// MARK: - Keyboard adjustments

extension ProfileViewController {
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(toggleKeyboard(notification:)),
                                               name: UIWindow.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(toggleKeyboard(notification:)),
                                               name: UIWindow.keyboardWillHideNotification,
                                               object: nil)
    }
    
    func unregisterForKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func toggleKeyboard(notification: Notification) {
        
        print("toggle keyboard with notification: \(notification)")
        
        let animationDuration = notification.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
        let animationCurve = notification.userInfo![UIResponder.keyboardAnimationCurveUserInfoKey] as! UInt
        let targetFrame = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        updateLayout(targetFrame: targetFrame, animationDuration: animationDuration, animationCurve: animationCurve)
    }
    
    func updateLayout(targetFrame: CGRect, animationDuration: Double, animationCurve: UInt) {
        if targetFrame.minY >= view.bounds.height {
            // Keyboard is being dismissed
            viewContainerTopConstraint.constant = 0
        } else {
            viewContainerTopConstraint.constant = UIScreen.main.sizeType == .iPhone5 ? -200 : -150
        }
        
        UIView.animate(withDuration: animationDuration, delay: 0, options: UIView.AnimationOptions(rawValue: animationCurve), animations: {
            self.view.layoutIfNeeded()
        })
    }
}

// MARK: - ProfileViewController (Private API)

private extension ProfileViewController {
    
    @objc func signOut() {
        do {
            try Auth.auth().signOut()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) { [weak self] in
                self?.navigationController?.popViewController(animated: false)
            }
        } catch {
            print("WARNING: Failed to sign out user!")
        }
    }
    
    func fetchUserData() {
        InternalUser.fetchUserData { [weak self] (error) in
            if let error = error {
                print("user data fetching failed \(error)")
            }
    
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
            
        }
    }
    
    func saveUserData() {
        InternalUser.update { (error) in
            if let error = error {
                print("user data saving failed \(error)")
            }
        }
    }
}
