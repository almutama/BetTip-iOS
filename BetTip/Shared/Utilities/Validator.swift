//
//  Validator.swift
//  BetTip
//
//  Created by Haydar Karkin on 27.11.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import Reactant

let loginCredentialsRule: Rule<(email: String, password: String), CredentialsValidationError> = Rule { email, password in
    if let emailError = Rules.String.email.validate(email) {
        return .emailInvalid(emailError)
    }
    
    guard Rules.String.notEmpty.test(password) else {
        return .passwordEmpty
    }
    
    guard Rules.String.minLength(1).test(password) else {
        return .passwordTooShort(minLength: 1)
    }
    
    return nil
}

let registrationCredentialsRule: Rule<(email: String, password: String, confirm: String), CredentialsValidationError> = Rule { email, password, confirm in
    if let emailError = Rules.String.email.validate(email) {
        return .emailInvalid(emailError)
    }
    
    guard Rules.String.notEmpty.test(password) else {
        return .passwordEmpty
    }
    
    guard Rules.String.minLength(6).test(password) else {
        return .passwordTooShort(minLength: 6)
    }
    
    if password != confirm {
        return .confirmNotMatch
    }
    
    return nil
}

enum CredentialsValidationError: Error {
    case emailInvalid(Rules.String.EmailValidationError)
    case passwordEmpty
    case passwordTooShort(minLength: Int)
    case confirmNotMatch
}
