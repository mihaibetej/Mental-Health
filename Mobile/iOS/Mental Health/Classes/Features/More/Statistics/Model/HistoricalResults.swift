//
//  HistoricalResults.swift
//  Mental Health
//
//  Created by Mihai Betej on 12/04/2020.
//  Copyright © 2020 Mihai Betej. All rights reserved.
//

import Foundation

//struct HistoricalResults: Codable {
//    let items: [HistoricalResult]
//}

struct HistoricalResult: Codable {
    let created: Date
    let items: [HistoricalResultItem]
    
    var score: Int {
        return items.reduce(0) { (result, item) -> Int in
            return result + item.answer_value
        }
    }
}

struct HistoricalResultItem: Codable {
    let answer_value: Int
}
