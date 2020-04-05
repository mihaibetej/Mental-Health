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

    static let shared = Session()
        
    private(set) var dataBase: Firestore
    
    init() {
        dataBase = Firestore.firestore()
    }
        
}
