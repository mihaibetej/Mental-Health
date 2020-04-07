//
//  QuestionnaireResultsViewModel.swift
//  Mental Health
//
//  Created by Mihai Betej on 05/04/2020.
//  Copyright © 2020 Mihai Betej. All rights reserved.
//

import Foundation
import UIKit

class QuestionnaireResultsViewModel {
        
    private enum ResultsType {
        case good
        case inconclusive
        case bad
        case none
    }
            
    private  struct ResultsRangeConstants {
        static let goodRange = 0..<20
        static let inconclusiveRange = 20..<40
        static let badRange = 40...60
    }

    private var resultsType: ResultsType = .none
    
    var score: Int = 0 {
        didSet {
            switch score {
            case ResultsRangeConstants.goodRange:
                resultsType = .good
            case ResultsRangeConstants.inconclusiveRange:
                resultsType = .inconclusive
            case ResultsRangeConstants.badRange:
                resultsType = .bad
            default:
                resultsType = .inconclusive
            }
        }
    }
    
    var title: String = "Rezultate chestionar"
    
    var resultsText: String {
        switch resultsType {
        case .good:
            return "Ne bucurăm că starea ta este una bună, suntem aici pentru ține dacă ai nevoie de un specialist în sănătate mintală."
        case .inconclusive:
            return "Nivelul tău de echilibru emoțional este unul mediu. Îți recomandăm să reaplici chestionarul în câteva zile pentru o monitorizare mai atentă a stării psihice si să vorbești cu un specialist despre stările tale."
        case .bad:
            return "Pare că ai trecut prin multe în ultima vreme, considerăm că este necesar să vorbești cu un specialist despre stările tale."
        case .none:
            return "Suntem mereu alături de tine si avem pe cineva gata să vorbească cu tine!"
        }
    }
    
    var recommendationText: String {
        if resultsType == .none {
            return "Ne poți apela la numărul de mai jos, acum sau oricând simți că ai nevoie!"
        }
        
        return "Ai grijă de tine!"
    }
    
    var recommendationLabelColor: UIColor {
        if resultsType == .none {
            if #available(iOS 13.0, *) {
                return .label
            } else {
                return .black
            }
        }
        
        return .mhRecommendation
    }
    
    var recommendationLabelFont: UIFont {
        if resultsType == .none {
            return UIFont.systemFont(ofSize: 20, weight: .semibold)
        }
        
        return UIFont.systemFont(ofSize: 28, weight: .light)
    }
    
    lazy var paragraphStyleTitle: NSMutableParagraphStyle = {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 6
        
        return paragraphStyle
    }()
    
    var paragraphStyleRecommendation: NSMutableParagraphStyle? {
        guard resultsType == .none else {
            return nil
        }
        
        return paragraphStyleTitle
    }
    
}
