//
//  FeedViewController.swift
//  Mental Health
//
//  Created by Mihai Betej on 27/03/2020.
//  Copyright © 2020 Mihai Betej. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {
    
    let detailSegueName = "showFeedDetail"
    var selectedDetails: Any?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == detailSegueName,
            let destination = segue.destination as? FeedDetailViewController {
            // pass the data in selectedDetails then erase the information in it
            destination.feedDetail = nil//pass the info here
            selectedDetails = nil
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell") as? FeedTableViewCell else {
            return FeedTableViewCell()
        }
        
//        cell.configure(title: "", image: UIImage())
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //extract selectedDetails from model
        performSegue(withIdentifier: detailSegueName, sender: self)
    }
}
