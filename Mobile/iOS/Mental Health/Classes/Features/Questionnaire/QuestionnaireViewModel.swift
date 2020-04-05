//
//  QuestionnaireViewModel.swift
//  Mental Health
//
//  Created by Mihai Betej on 31/03/2020.
//  Copyright © 2020 Mihai Betej. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

// MARK: - QuestionnaireViewModelDelegate

protocol QuestionnaireViewModelDelegate: class {
    func willUpdate()
    func didUpdate()
    func didFailToUpdate(with error: Error)
}

// MARK: - QuestionnaireViewModel

class QuestionnaireViewModel {
    // MARK: Variables
    weak var delegate: QuestionnaireViewModelDelegate?
    
    private var dataSource = [Question]()
        
    // MARK: Lifecycle
    
    init(delegate: QuestionnaireViewModelDelegate?) {
        //loadMockedData()
        self.delegate = delegate
        loadData()
    }
        
}

// MARK: - QuestionnaireViewModel (public API)

extension QuestionnaireViewModel {
    
    var numberOfRows: Int {
        return dataSource.count == 0 ? 0 : dataSource.count + 1
    }
    
    func question(for index: Int) -> Question? {
        guard index < dataSource.count else {
            return nil
        }
        
        return dataSource[index]
    }
    
    func updateQuestion(at index: Int, with answer: Int) {
        dataSource[index].updateAnswer(value: answer)
    }
    
    var score: Int {
        return dataSource.reduce(0) { (result, question) -> Int in
            return result + question.score
        }
    }
    
}

// MARK: - QuestionnaireViewModel (private API)

private extension QuestionnaireViewModel {
    
    func loadMockedData() {
        dataSource.removeAll()
        let path = Bundle.main.path(forResource: "Questionnaire", ofType: "json")!
        let url = URL(fileURLWithPath: path)
        
        guard let data = try? Data(contentsOf: url) else {
            let customError = NSError(domain: "read.error", code: 0, userInfo: ["message" : "Unable to load data"])
            delegate?.didFailToUpdate(with: customError)
            return
        }
        
        let decoder = JSONDecoder()
        let questions = try! decoder.decode([Question].self, from: data)
        dataSource.append(contentsOf: questions)
        
        delegate?.didUpdate()
    }
    
    func loadNetworkData() {
        Session.shared.dataBase.collection("questions").getDocuments { [weak self] (snapshot, error) in
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
                        if let question = try document.data(as: Question.self) {
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
    
    func loadData() {
        delegate?.willUpdate()
        if ProcessInfo.processInfo.environment["use_mock_data"] == "YES" {
            loadMockedData()
        } else {
            loadNetworkData()
        }
    }
    
}
