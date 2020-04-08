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
    let email: String
    let authenticatedUserId: String
    var internalUserId: String!
    
    private enum CodingKeys: String, CodingKey {
        case email, authenticatedUserId = "id"
    }
    
    static func getCurrent(completion: @escaping (InternalUser?) -> ()) {
        let usersCollection = Session.shared.dataBase.collection("users")
        
        guard let authenticatedUserId = Auth.auth().currentUser?.uid,
            let email = Auth.auth().currentUser?.email else {
            completion(nil)
            return
        }
        
        let query = usersCollection.whereField("id", isEqualTo: authenticatedUserId)
        
        //if the user is not found, create one
        let processUser = { (user: InternalUser?) -> () in
            if let user = user {
                completion(user)
                return
            }
            let uuid = UUID().uuidString
            usersCollection.document(uuid).setData (["email": email, "id": authenticatedUserId]) { err in
                if let _ = err {
                    completion(nil)
                } else {
                    completion(InternalUser(email: email,
                                            authenticatedUserId: authenticatedUserId,
                                            internalUserId: uuid))
                }
            }
        }
        
        query.getDocuments { (snapshot, error) in
            guard let snapshot = snapshot else {
                processUser(nil)
                return
            }
            if let document = snapshot.documents.first {
                do {
                    if var user = try document.data(as: InternalUser.self) {
                        user.internalUserId = document.documentID
                        processUser(user)
                        return
                    }
                } catch {}
            }
            processUser(nil)
        }
    }
}
