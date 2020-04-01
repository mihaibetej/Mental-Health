//
//  JournalViewController.swift
//  Mental Health
//
//  Created by Florin Voicu on 4/1/20.
//  Copyright © 2020 Mihai Betej. All rights reserved.
//

import UIKit

class JournalViewController: UIViewController {
    
    struct Segues {
        static let journal = "embedJournal"
        static let graph = "embedGraph"
    }
    
    @IBOutlet weak var journalContainer: UIView!
    @IBOutlet weak var graphContainer: UIView!
    
    lazy var journalItems = loadJson(name: "Journal")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UISegmentedControl.appearance().setTitleTextAttributes(titleTextAttributes, for: .selected)
        title = "Jurnal personal"
    }
    
    //MARK: - Actions
    
    @IBAction func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            journalContainer.isHidden = false
        case 1:
            journalContainer.isHidden = true
        default:
            break
        }
        graphContainer.isHidden = !graphContainer.isHidden
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
        case Segues.journal:
            destination?.items = journalItems
            destination?.config = .init(allowsAdding: true)
        default:
            break
        }
    }

}
