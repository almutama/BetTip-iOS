//
//  AuthError.swift
//  BetTip
//
//  Created by Haydar Karkin on 25.11.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import Foundation

enum AuthenticationError: Error {
    case firebaseError(FirebaseLoginError)
    case unknown
}

enum DeauthenticationError: Error {
    case firebaseError(FirebaseCommonError)
    case unknown
}
