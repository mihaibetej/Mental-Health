//
//  Session.swift
//  Mental Health
//
//  Created by Mihai Betej on 05/04/2020.
//  Copyright © 2020 Mihai Betej. All rights reserved.
//

import Foundation
import Firebase

// MARK: - Session

class Session {

    // MARK: variables
    
    static let shared = Session()
        
    private(set) var dataBase: Firestore
    
    private lazy var dateFormatterISO8601: DateFormatter = {
        let dateFormatter = DateFormatter()
        let enUSPosixLocale = Locale(identifier: "en_US_POSIX")
        dateFormatter.locale = enUSPosixLocale
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.calendar = Calendar(identifier: .gregorian)

        return dateFormatter
    }()
    
    private struct StorageKeys {
        static let checkInDates = "checkInDates"
    }
    
    private var todayAsString: String {
        return dateFormatterISO8601.string(from: Date())
    }
    
    // MARK: lifecycle
    
    init() {
        dataBase = Firestore.firestore()
    }
    
    // MARK: public API
    
    var isCheckInNeeded: Bool {
        guard let storedCheckIns = UserDefaults.standard.value(forKey: StorageKeys.checkInDates) as? [String] else {
            return true
        }
        
        return storedCheckIns.contains(todayAsString) == false
    }
    
    func addCheckIn() {
        guard let storedCheckIns = UserDefaults.standard.value(forKey: StorageKeys.checkInDates) as? [String] else {
            UserDefaults.standard.setValue([todayAsString], forKey: StorageKeys.checkInDates)
            return
        }
        
        if storedCheckIns.contains(todayAsString) == false {
            var updatedStoredCheckIns = [String]()
            updatedStoredCheckIns.append(contentsOf: storedCheckIns)
            updatedStoredCheckIns.append(todayAsString)
            UserDefaults.standard.setValue(updatedStoredCheckIns, forKey: StorageKeys.checkInDates)
        }
    }
        
}
