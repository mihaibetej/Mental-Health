//
//  JournalViewController.swift
//  Mental Health
//
//  Created by Florin Voicu on 4/1/20.
//  Copyright © 2020 Mihai Betej. All rights reserved.
//

import UIKit
import Firebase
import IHProgressHUD

// MARK: - JournalViewController

class JournalViewController: UIViewController {
    
    struct Segues {
        static let journal = "embedJournal"
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as? ExpandableListViewController
        switch segue.identifier {
        case Segues.journal:
            destination?.viewModel = JournalViewModel(delegate: destination)
            destination?.config = .init(allowsAdding: true)
        default:
            break
        }
    }
    
    // MARK: - Private
    
    func setupUI() {
        title = "Jurnalul eroului"
        let titleParagraphText = NSMutableAttributedString(string: "Adaugă și azi o nouă poveste în jurnalul eroului. Cărei intămplare îi ești azi recunoscător?")
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 6
        titleParagraphText.addAttribute(NSAttributedString.Key.paragraphStyle,
                                value: paragraphStyle,
                                range:NSMakeRange(0, titleParagraphText.length))
        titleLabel.attributedText = titleParagraphText
    }
}
