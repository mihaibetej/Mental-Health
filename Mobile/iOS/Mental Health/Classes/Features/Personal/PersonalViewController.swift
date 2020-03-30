//
//  PersonalViewController.swift
//  Mental Health
//
//  Created by Mihai Betej on 27/03/2020.
//  Copyright © 2020 Mihai Betej. All rights reserved.
//

import UIKit

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
    
    lazy var advices = loadJson(name: "Advices")
    lazy var messages = loadJson(name: "Messages")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UISegmentedControl.appearance().setTitleTextAttributes(titleTextAttributes, for: .selected)
        title = "Pentru tine"
    }
    
    //MARK: - Actions
    
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
    
    //MARK: - Private
    
    private func loadJson(name: String) -> [ExpandableListItem] {
        let path = Bundle.main.path(forResource: name, ofType: "json")!
        let url = URL(fileURLWithPath: path)
        let data = try! Data(contentsOf: url)
        
        let decoder = JSONDecoder()
        
        let items = try! decoder.decode([ExpandableListItem].self, from: data)
        return items
    }
    
    //MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as? ExpandableListViewController
        switch segue.identifier {
        case Segues.advices:
            destination?.items = advices
        case Segues.messages:
            destination?.items = messages
        default:
            break
        }
    }

}
