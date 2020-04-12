//
//  StatisticsViewController.swift
//  Mental Health
//
//  Created by Mihai Betej on 06/04/2020.
//  Copyright © 2020 Mihai Betej. All rights reserved.
//

import UIKit

// MARK: - StatisticsViewController

class StatisticsViewController: UIViewController {

    // MARK: Variables
        
    @IBOutlet weak var statisticsTypeSwitch: MHSegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    private lazy var viewModel: StatisticsViewModel = {
        let viewModel = StatisticsViewModel(delegate: self)
        return viewModel
    }()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Statistici"
        viewModel.loadData()
    }
    
    // MARK: Actions
    
    @IBAction func statisticsTypeChanged(_ sender: Any) {
        viewModel.changeStatisticsType(to: statisticsTypeSwitch.selectedSegmentIndex)
    }    
    
}

// MARK: - StatisticsViewController

extension StatisticsViewController: StatisticsViewModelDelegate {
    
    func willUpdate() {
        // TODO
    }
    
    func didUpdate() {
        tableView.reloadData()
    }
    
    func didFailToUpdate(with error: Error) {
        // TODO
    }
    
}

// MARK: - StatisticsViewController (UITableViewDataSource, UITableViewDelegate)

extension StatisticsViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: Data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoricalResultTableViewCell", for: indexPath) as! HistoricalResultTableViewCell
        cell.configure(viewModel: viewModel, index: indexPath.row)
        
        return cell
    }
    
}
