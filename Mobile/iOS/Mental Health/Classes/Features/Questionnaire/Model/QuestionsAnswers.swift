//
//  QuestionsAnswers.swift
//  Mental Health
//
//  Created by Mihai Betej on 08/04/2020.
//  Copyright © 2020 Mihai Betej. All rights reserved.
//

import Foundation

struct QuestionsAnswers: Codable {
    let created: Date
    let items: [QuestionResult]
}

struct QuestionResult: Codable {
    let answer_title: String
    let answer_value: Int
    let question_body: String
    let question_id: String
}
