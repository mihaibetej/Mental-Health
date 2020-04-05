//
//  QuestionnaireResultsViewModel.swift
//  Mental Health
//
//  Created by Mihai Betej on 05/04/2020.
//  Copyright © 2020 Mihai Betej. All rights reserved.
//

import Foundation

class QuestionnaireResultsViewModel {
    
    enum ResultsType {
        case good
        case inconclusive
        case bad
    }
    
    var resultsType: ResultsType = .inconclusive
    
    var resultsText: String {
        switch resultsType {
        case .good:
            return "Ne bucurăm că starea ta este una bună, suntem aici pentru ține dacă ai nevoie de un specialist în sănătate mintală."
        case .inconclusive:
            return "Nivelul tău de echilibru emoțional este unul mediu. Îți recomandăm să reaplici chestionarul în câteva zile pentru o monitorizare mai atentă a stării psihice si să vorbești cu un specialist despre stările tale."
        case .bad:
            return "Pare că ai trecut prin multe în ultima vreme, considerăm că este necesar să vorbești cu un specialist despre stările tale."
        }
    }
}
