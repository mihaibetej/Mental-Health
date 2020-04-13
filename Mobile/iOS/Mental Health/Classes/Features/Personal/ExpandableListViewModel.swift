//
//  PersonalViewModel.swift
//  Mental Health
//
//  Created by George Muntean on 13/04/2020.
//  Copyright © 2020 Mihai Betej. All rights reserved.
//

import Foundation

// MARK: - ExpandableListViewModelDelegate

protocol ExpandableListViewModelDelegate: class {
    func willUpdate()
    func didUpdate()
    func didFailToUpdate(with error: Error)
}

// MARK: - ExpandableListViewModel

class ExpandableListViewModel {
    
    // MARK: Variables
    
    weak var delegate: ExpandableListViewModelDelegate?
    
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, dd MMMM"
        dateFormatter.locale = Locale(identifier: "ro")
        return dateFormatter
    }()
    
    var dataSource = [ExpandableListItem]()
        
    // MARK: Lifecycle
    
    init(delegate: ExpandableListViewModelDelegate?) {
        self.delegate = delegate
        loadData()
    }
    
    // MARK: Overridden In Subclasses
    
    func addData(title: String, text: String) {}
    func loadData() {}
}


// MARK: - ExpandableListViewModel (public API)

extension ExpandableListViewModel {
    
    var numberOfRows: Int {
        return dataSource.count
    }
    
    func item(for index: Int) -> ExpandableListItem? {
        guard index < dataSource.count else {
            return nil
        }
        return dataSource[index]
    }
}

