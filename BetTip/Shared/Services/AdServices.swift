//
//  AdServices.swift
//  BetTip
//
//  Created by Haydar Karkin on 20.05.2018.
//  Copyright © 2018 Haydar Karkin. All rights reserved.
//

import RxSwift
import Firebase
import FirebaseDatabase
import Result

protocol AdServiceType {
    func getSpecificAd() -> Observable<Result<AdModel, FirebaseFetchError>>
}

class AdService: AdServiceType {
    
    func getSpecificAd() -> Observable<Result<AdModel, FirebaseFetchError>> {
        return Database.database().reference()
            .child(Constants.advertisement).fetch()
    }
}
