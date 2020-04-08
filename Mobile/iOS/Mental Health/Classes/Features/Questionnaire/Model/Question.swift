//
//  Question.swift
//  Mental Health
//
//  Created by Mihai Betej on 31/03/2020.
//  Copyright © 2020 Mihai Betej. All rights reserved.
//

import Foundation

struct Question: Codable {
    
    let body: String
    let answers: [Answer]
    var userAnswer: Int?
    var id: String?
        
    mutating func updateAnswer(value: Int) {
        userAnswer = value
    }
    
    mutating func updateId(value: String) {
        id = value
    }
        
}

extension Question {
    
    var defaultUserAnswer: Int {
        return 2
    }
    
    var score: Int {
        return answers.count - (userAnswer ?? defaultUserAnswer)
    }
    
    var answerTitleForCurrentScore: String {
        let answerValue = userAnswer ?? defaultUserAnswer
        return answers.first(where: {$0.value == answerValue})?.title ?? ""
    }

    var questionId: String {
        return id ?? UUID().uuidString
    }
    
}

struct Answer: Codable {
    let title: String
    let value: Int
}
