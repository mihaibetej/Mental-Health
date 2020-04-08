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
    enum ErrorType: Error {
        case noUserIdAvailale
    }
    static var shared = InternalUser()
    
    static var email: String? { Auth.auth().currentUser?.email }
    static var id: String? { Auth.auth().currentUser?.uid }
    
    var town: String?
    var hospital: String?
    var jobTitle: String?
    var phoneNo: String?
    
    static func update(using additionalData: [String: String] = [:], completion: @escaping (_ error: Error?) -> () ) {
        guard let email = email, let id = id else {
            completion(ErrorType.noUserIdAvailale)
            return
        }
        
        let data = ["email": email,
                    "id": id,
                    "town": shared.town ?? "",
                    "hospital": shared.hospital ?? "",
                    "jobTitle": shared.jobTitle ?? "",
                    "phoneNo": shared.phoneNo ?? "",]
        let usersCollection = Session.shared.dataBase.collection("users")
        usersCollection.document(id).setData (data) { error in
            if let error = error {
                completion(error)
            } else {
                completion(nil)
            }
        }
    }
    
    static func fetchUserData(completion: @escaping (_ error: Error?) -> () ) {
        guard let id = id else {
            completion(ErrorType.noUserIdAvailale)
            return
        }
        let usersCollection = Session.shared.dataBase.collection("users")
        usersCollection.document(id).getDocument { (document, error) in
            if let error = error {
                print("failed to fetch user data: \(error)")
                completion(error)
                return
            }
            
            do {
                if let internaluser = try document?.data(as: InternalUser.self) {
                    InternalUser.shared = internaluser
                }
                completion(nil)
            } catch {
                print("why you do this to me, user data fetching? \(error)")
                completion(error)
            }
        }
    }
}
