//
//  AdviceViewModel.swift
//  Mental Health
//
//  Created by George Muntean on 13/04/2020.
//  Copyright © 2020 Mihai Betej. All rights reserved.
//

import Foundation


// MARK: - AdviceViewModel

class AdviceViewModel: ExpandableListViewModel {
    
    override func loadData() {
        delegate?.willUpdate()
        Session.shared.dataBase
            .collection("daily-advices")
            .order(by: "publishDate")
            .getDocuments { (snapshot, error) in
                if let error = error {
                    self.delegate?.didFailToUpdate(with: error)
                    return
                } else {
                    guard let snapshot = snapshot else {
                        let customError = NSError(domain: "no.results", code: 0, userInfo: ["message" : "No results found"])
                        self.delegate?.didFailToUpdate(with: customError)
                        return
                    }
                    
                    var tempAdvices = [ExpandableListItem]()
                    for document in snapshot.documents {
                        do {
                            if let dailyAdvice = try document.data(as: DailyAdvice.self) {
                                
                                let title = self.dateFormatter.string(from: dailyAdvice.publishDate)
                                let item = ExpandableListItem(title: title.capitalizingFirstLetter(),
                                                              text: dailyAdvice.body)
                                tempAdvices.append(item)
                            }
                        } catch {}
                    }
                    
                    self.dataSource.removeAll()
                    self.dataSource.append(contentsOf: tempAdvices.reversed())
                    self.delegate?.didUpdate()
                }
        }
    }
}

