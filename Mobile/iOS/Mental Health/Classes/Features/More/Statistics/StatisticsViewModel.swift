//
//  StatisticsViewModel.swift
//  Mental Health
//
//  Created by Mihai Betej on 09/04/2020.
//  Copyright © 2020 Mihai Betej. All rights reserved.
//

import Foundation

// MARK: - StatisticsViewModelDelegate

protocol StatisticsViewModelDelegate: class {
    func willUpdate()
    func didUpdate()
    func didFailToUpdate(with error: Error)
}

// MARK: - StatisticsViewModel

class StatisticsViewModel {
    
    // MARK: Variables
    
    private var dataSource = [Any]()
    private weak var delegate: StatisticsViewModelDelegate?
    
    // MARK: Lifecycle
    
    init(delegate: StatisticsViewModelDelegate?) {
        self.delegate = delegate
        loadData()
    }
    
}

// MARK: - StatisticsViewModel (Public API)

extension StatisticsViewModel {
    
    var numberOfSections: Int {
        return dataSource.count > 0 ? 1 : 0
    }
    
    var numberOfRows: Int {
        return dataSource.count
    }
    
    func loadData() {
        loadNetworkData()
    }

}

// MARK: - StatisticsViewModel (Private API)

private extension StatisticsViewModel {
    
    func loadNetworkData() {
        delegate?.willUpdate()
        guard let userId = InternalUser.id else {
            let customError = NSError(domain: "user.error", code: 0, userInfo: ["message" : "Actiunea nu poate a putut fi executata. Id utilizator inexistent!"])
            delegate?.didFailToUpdate(with: customError)
            return
        }
        
        Session.shared.dataBase
            .collection("users")
            .document(userId)
            .collection("answers").getDocuments { [weak self] (snapshot, error) in
            if let error = error {
                self?.delegate?.didFailToUpdate(with: error)
            } else {
                guard let snapshot = snapshot else {
                    let customError = NSError(domain: "no.results", code: 0, userInfo: ["message" : "No results found"])
                    self?.delegate?.didFailToUpdate(with: customError)
                    return
                }
                
                // 'document' is a dictionary
                var questions = [Question]()
                for document in snapshot.documents {
                    do {
                        if var question = try document.data(as: Question.self) {
                            question.updateId(value: document.documentID)
                            questions.append(question)
                            print(question)
                        }
                    } catch {}
                }
                
                DispatchQueue.main.async {
                    self?.dataSource.removeAll()
                    self?.dataSource.append(contentsOf: questions)
                    
                    self?.delegate?.didUpdate()
                }
            }
        }

    }
    
}
