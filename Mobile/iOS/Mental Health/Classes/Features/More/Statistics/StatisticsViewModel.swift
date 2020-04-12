//
//  StatisticsViewModel.swift
//  Mental Health
//
//  Created by Mihai Betej on 09/04/2020.
//  Copyright © 2020 Mihai Betej. All rights reserved.
//

import Foundation
import UIKit

// MARK: - StatisticsViewModelDelegate

protocol StatisticsViewModelDelegate: class {
    func willUpdate()
    func didUpdate()
    func didFailToUpdate(with error: Error)
}

// MARK: - StatisticsViewModel

class StatisticsViewModel {
    
    // MARK: Variables
    
    private var dataSource = [HistoricalResult]()
    
    private weak var delegate: StatisticsViewModelDelegate?
    
    private enum StatisticsType: Int {
        case checkin = 0
        case questionnaire
    }
    
    private var statisticsType: StatisticsType = .checkin {
        didSet {
            
        }
    }
    
    private enum ResultsType {
        case good(UIImage?)
        case inconclusive(UIImage?)
        case bad(UIImage?)
        case none
        
        init(result: Int) {
            switch result {
            case ResultsRangeConstants.goodRange:
                self = .good(UIImage(named: "happy-face"))
            case ResultsRangeConstants.inconclusiveRange:
                self = .inconclusive(UIImage(named: "normal-face"))
            case ResultsRangeConstants.badRange:
                self = .bad(UIImage(named: "sad-face"))
            default:
                self = .none
            }
        }
        
        func getImage() -> UIImage? {
            switch self {
            case .good(let image), .inconclusive(let image), .bad(let image):
                return image
            default:
                return nil
            }
        }
    }
            
    private  struct ResultsRangeConstants {
        static let goodRange = 0..<20
        static let inconclusiveRange = 20..<40
        static let badRange = 40...60
    }

    
    // MARK: Lifecycle
    
    init(delegate: StatisticsViewModelDelegate?) {
        self.delegate = delegate
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
    
    
    func resultImage(for index: Int) -> UIImage? {
        guard let result = historicalResult(at: index) else {
            return nil
        }
        
        return ResultsType(result: result.score).getImage()
    }
    
    func resultDateReadable(for index: Int) -> String {
        return Session.shared.readable(date: historicalResult(at: index)?.created ?? Date())
    }
    
    func resultScoreReadable(for index: Int) -> String {
        return "Scor chestionar - \(historicalResult(at: index)?.score ?? 0) puncte"
    }
    
    func changeStatisticsType(to value: Int) {
        statisticsType = StatisticsType(rawValue: value) ?? .checkin
    }
    
    func loadData() {
        loadNetworkData()
    }

}

// MARK: - StatisticsViewModel (Private API)

private extension StatisticsViewModel {
    
    func historicalResult(at index: Int) -> HistoricalResult? {
        guard index < dataSource.count else {
            return nil
        }
        
        return dataSource[index]
    }
    
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
            .collection("answers")
            .order(by: "created")
            .getDocuments { [weak self] (snapshot, error) in
            if let error = error {
                self?.delegate?.didFailToUpdate(with: error)
            } else {
                guard let snapshot = snapshot else {
                    let customError = NSError(domain: "no.results", code: 0, userInfo: ["message" : "No results found"])
                    self?.delegate?.didFailToUpdate(with: customError)
                    return
                }
                
                // 'document' is a dictionary
                var historicalResults = [HistoricalResult]()
                for document in snapshot.documents {
                    do {
                        if let historicalResult = try document.data(as: HistoricalResult.self) {
                            historicalResults.append(historicalResult)
                        }
                    } catch {}
                }
                
                DispatchQueue.main.async {
                    self?.dataSource.removeAll()
                    self?.dataSource.append(contentsOf: historicalResults.reversed())
                    
                    self?.delegate?.didUpdate()
                }
            }
        }

    }
    
}
