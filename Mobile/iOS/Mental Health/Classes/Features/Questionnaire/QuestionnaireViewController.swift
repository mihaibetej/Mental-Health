//
//  QuestionnaireViewController.swift
//  Mental Health
//
//  Created by Mihai Betej on 27/03/2020.
//  Copyright © 2020 Mihai Betej. All rights reserved.
//

import UIKit

// MARK: - QuestionnaireViewController

class QuestionnaireViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Chestionar" 
    }
    
}

// MARK: - QuestionnaireViewController (UITableViewDataSource, UITableViewDelegate)

extension QuestionnaireViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionTableViewCell", for: indexPath) as! QuestionTableViewCell
        cell.configure(delegate: self)
        
        return cell
    }
    
}

// MARK: - QuestionnaireViewController (AnswerDelegate)

extension QuestionnaireViewController: AnswerDelegate {
    
    func answerUpdated(for cell: QuestionTableViewCell) {
        
    }
    
}
