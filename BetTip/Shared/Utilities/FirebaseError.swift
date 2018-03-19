//
//  FirebaseError.swift
//  BetTip
//
//  Created by Haydar Karkin on 24.11.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import Firebase

enum FirebaseCommonError: Error {
    case networkError
    case userNotFound
    case userTokenExpired
    case tooManyRequests
    case invalidAPIKey
    case appNotAuthorized
    case keychainError
    case internalError
    case unknown
    
    init(error: NSError) {
        let firebaseError = AuthErrorCode(rawValue: error.code)
        
        switch firebaseError {
        case .networkError?:
            self = .networkError
        case .userNotFound?:
            self = .userNotFound
        case .userTokenExpired?:
            self = .userTokenExpired
        case .tooManyRequests?:
            self = .tooManyRequests
        case .invalidAPIKey?:
            self = .invalidAPIKey
        case .appNotAuthorized?:
            self = .appNotAuthorized
        case .keychainError?:
            self = .keychainError
        case .internalError?:
            self = .internalError
        default:
            self = .unknown
        }
    }
}

enum FirebaseLoginError: Error {
    case common(FirebaseCommonError)
    case operationNotAllowed
    case userDisabled
    case wrongPassword
    
    init(error: NSError) {
        let firebaseError = AuthErrorCode(rawValue: error.code)
        
        switch firebaseError {
        case .operationNotAllowed?:
            self = .operationNotAllowed
        case .userDisabled?:
            self = .userDisabled
        case .wrongPassword?:
            self = .wrongPassword
        default:
            self = .common(FirebaseCommonError(error: error))
        }
    }
}

enum FirebaseSignupError: Error {
    case common(FirebaseCommonError)
    case invalidEmail
    case emailAlreadyInUse
    case operationNotAllowed
    case weakPassword(reason: String)
    
    init(error: NSError) {
        let firebaseError = AuthErrorCode(rawValue: error.code)
        
        switch firebaseError {
        case .invalidEmail?:
            self = .invalidEmail
        case .emailAlreadyInUse?:
            self = .emailAlreadyInUse
        case .operationNotAllowed?:
            self = .operationNotAllowed
        case .weakPassword?:
            let reason = error.userInfo[NSLocalizedFailureReasonErrorKey] as? String ?? ""
            self = .weakPassword(reason: reason)
        default:
            self = .common(FirebaseCommonError(error: error))
        }
    }
}
