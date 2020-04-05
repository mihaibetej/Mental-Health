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
    
    var defaultUserAnswer: Int {
        return 2
    }
    
    mutating func updateAnswer(value: Int) {
        userAnswer = value
    }
    
    var score: Int {
        return answers.count - (userAnswer ?? defaultUserAnswer)
    }
    
}

struct Answer: Codable {
    let title: String
    let value: Int
}
