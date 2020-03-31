//
//  QuestionnaireViewModel.swift
//  Mental Health
//
//  Created by Mihai Betej on 31/03/2020.
//  Copyright © 2020 Mihai Betej. All rights reserved.
//

import Foundation

class QuestionnaireViewModel {
    var dataSource = [Question]()
    
    var numberOfRows: Int {
        return dataSource.count == 0 ? 0 : dataSource.count + 1
    }
    
    init() {
        loadData()
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
    
}

private extension QuestionnaireViewModel {
    
    func loadData() {
        dataSource.removeAll()
        
        let path = Bundle.main.path(forResource: "Questionnaire", ofType: "json")!
        let url = URL(fileURLWithPath: path)
        let data = try! Data(contentsOf: url)
        
        let decoder = JSONDecoder()
        
        let questions = try! decoder.decode([Question].self, from: data)
        dataSource.append(contentsOf: questions.sorted(by: {
            $0.index < $1.index
        }))
    }
    
}
