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
import FirebaseStorage
import Result

protocol AdServiceType {
    func getSpecificAd() -> Observable<Result<AdModel, FirebaseFetchError>>
    func addAd(with ad: AdModel) -> Observable<Result<AdModel, FirebaseStoreError>>
    func updateAd(with ad: AdModel) -> Observable<Result<AdModel, FirebaseStoreError>>
    func getBannerImgURL(filePath: String) -> Observable<URL?>
}

class AdService: AdServiceType {
    
    func getSpecificAd() -> Observable<Result<AdModel, FirebaseFetchError>> {
        return Database.database().reference()
            .child(Constants.advertisement).fetch()
    }
    
    func addAd(with ad: AdModel) -> Observable<Result<AdModel, FirebaseStoreError>> {
        return Database.database().reference()
            .child(Constants.advertisement)
            .storeObject(ad)
    }
    
    func updateAd(with ad: AdModel) -> Observable<Result<AdModel, FirebaseStoreError>> {
        return Database.database().reference()
            .child(Constants.advertisement)
            .update(ad)
    }
    
    func getBannerImgURL(filePath: String) -> Observable<URL?> {
        return Storage.storage().reference()
            .child(filePath)
            .downloadURL()
    }
}
