//
//  User.swift
//  Mental Health
//
//  Created by George Muntean on 07/04/2020.
//  Copyright © 2020 Mihai Betej. All rights reserved.
//

import Foundation
import Firebase

struct InternalUser: Codable {
    static var email: String? { Auth.auth().currentUser?.email }
    static var id: String? { Auth.auth().currentUser?.uid }
    
    static func update(completion: @escaping (_ error: Error?) -> () ) {
        guard let email = email, let id = id else {
            return
        }
        let usersCollection = Session.shared.dataBase.collection("users")
        usersCollection.document(id).setData (["email": email, "id": id]) { error in
            if let error = error {
                completion(error)
            } else {
                completion(nil)
            }
        }
    }
}
