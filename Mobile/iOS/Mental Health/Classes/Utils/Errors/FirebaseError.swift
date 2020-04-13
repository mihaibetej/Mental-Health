//
//  Authentication.swift
//  Mental Health
//
//  Created by George Muntean on 13/04/2020.
//  Copyright © 2020 Mihai Betej. All rights reserved.
//

import UIKit
import Firebase

struct FirebaseError {
    let errorCode: AuthErrorCode?
    init(_ error: Error) {
        errorCode = AuthErrorCode(rawValue: (error as NSError).code)
    }
    public var errorMessage: String {
        switch errorCode {
        case .userNotFound, .wrongPassword:
            return  "authentication.errors.invalid_username_or_password".localized()
        case .emailAlreadyInUse:
            return "authentication.errors.email_already_in_use".localized()
        default:
           return "authentication.errors.generic".localized()
        }
    }
}
