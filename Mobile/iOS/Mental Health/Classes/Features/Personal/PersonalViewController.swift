//
//  PersonalViewController.swift
//  Mental Health
//
//  Created by Mihai Betej on 27/03/2020.
//  Copyright © 2020 Mihai Betej. All rights reserved.
//

import UIKit
import FirebaseFirestoreSwift
import IHProgressHUD

struct ExpandableListItem: Codable {
    let title: String
    let text: String
}

class PersonalViewController: UIViewController {
    
    struct Segues {
        static let advices = "embedAdvices"
        static let messages = "embedMessages"
    }
    
    @IBOutlet weak var advicesContainer: UIView!
    @IBOutlet weak var messagesContainer: UIView!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Pentru tine"
    }
    
    // MARK: - Actions
    
    @IBAction func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            advicesContainer.isHidden = false
        case 1:
            advicesContainer.isHidden = true
        default:
            break
        }
        messagesContainer.isHidden = !advicesContainer.isHidden
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as? ExpandableListViewController
        switch segue.identifier {
        case Segues.advices:
            destination?.viewModel = AdviceViewModel(delegate: destination)
        case Segues.messages:
            destination?.viewModel = MessageViewModel(delegate: destination)
        default:
            break
        }
    }
}
