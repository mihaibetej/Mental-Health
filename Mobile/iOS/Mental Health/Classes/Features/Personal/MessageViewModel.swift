//
//  MessageViewModel.swift
//  Mental Health
//
//  Created by George Muntean on 13/04/2020.
//  Copyright © 2020 Mihai Betej. All rights reserved.
//

import Foundation

// MARK: - MessageViewModel

class MessageViewModel: ExpandableListViewModel {
    
    override func loadData() {
        delegate?.willUpdate()
        Session.shared.dataBase
            .collection("messages")
            .order(by: "creationDate")
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
                    
                    var tempMessages = [ExpandableListItem]()
                    for document in snapshot.documents {
                        do {
                            if let message = try document.data(as: Message.self) {
                                let item = ExpandableListItem(title: message.from,
                                                              text: message.body)
                                tempMessages.append(item)
                            }
                        } catch {}
                    }
                    
                    self.dataSource.removeAll()
                    self.dataSource.append(contentsOf: tempMessages.reversed())
                    self.delegate?.didUpdate()
                }
        }
    }
}
