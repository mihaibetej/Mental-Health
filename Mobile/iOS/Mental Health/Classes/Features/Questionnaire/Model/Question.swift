//
//  Question.swift
//  Mental Health
//
//  Created by Mihai Betej on 31/03/2020.
//  Copyright © 2020 Mihai Betej. All rights reserved.
//

import Foundation

struct Question: Codable {
    let index: Int
    let text: String
    var answer: Int
    
    mutating func updateAnswer(value: Int) {
        answer = value
    }
}
