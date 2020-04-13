//
//  JournalViewModel.swift
//  Mental Health
//
//  Created by George Muntean on 13/04/2020.
//  Copyright © 2020 Mihai Betej. All rights reserved.
//

import Foundation


// MARK: - JournalViewModel

class JournalViewModel: ExpandableListViewModel {
    
    override func addData(title: String, text: String) {
        guard let userId = InternalUser.id else {
            let customError = NSError(domain: "no.results", code: 0, userInfo: ["message" : "Actiunea nu poate a putut fi executata!"])
            self.delegate?.didFailToUpdate(with: customError)
            return
        }
        
        Session.shared.dataBase
            .collection("users")
            .document(userId)
            .collection("journals")
            .addDocument(data: ["date": Date(), "body": text]) { err in
                if let error = err {
                    self.delegate?.didFailToUpdate(with: error)
                } else {
                    DispatchQueue.main.async {
                        self.dataSource.insert(.init(title: title, text: text), at: 0)
                        self.delegate?.didUpdate()
                    }
                }
        }
    }
    
    override func loadData() {
        delegate?.willUpdate()
        guard let userId = InternalUser.id else {
            let customError = NSError(domain: "read.error", code: 0, userInfo: ["message" : "Actiunea nu a putut fi executata"])
            self.delegate?.didFailToUpdate(with: customError)
            return
        }
        
        Session.shared.dataBase
            .collection("users")
            .document(userId)
            .collection("journals")
            .getDocuments { (snapshot, error) in
                if let error = error {
                    self.delegate?.didFailToUpdate(with: error)
                    return
                } else {
                    guard let snapshot = snapshot else {
                        let customError = NSError(domain: "no.results", code: 0, userInfo: ["message" : "No exista resultate"])
                        self.delegate?.didFailToUpdate(with: customError)
                        return
                    }
                    
                    var rawItems = [Journal]()
                    for document in snapshot.documents {
                        do {
                            if let journal = try document.data(as: Journal.self) {
                                rawItems.append(journal)
                            }
                        } catch {}
                    }
                    rawItems = rawItems.sorted(by: { $0.date > $1.date} )
                    self.dataSource = rawItems.map { rawItem in
                        let title = self.dateFormatter.string(from: rawItem.date)
                        let item = ExpandableListItem(title: title, text: rawItem.body)
                        return item
                    }
                    self.delegate?.didUpdate()
                }
                
        }
    }
}
