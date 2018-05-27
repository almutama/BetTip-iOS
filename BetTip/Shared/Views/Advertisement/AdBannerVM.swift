//
//  AdBannerViewModel.swift
//  BetTip
//
//  Created by Haydar Karkin on 20.05.2018.
//  Copyright © 2018 Haydar Karkin. All rights reserved.
//

import ObjectMapper
import RxSwift
import Result

private let logger = Log.createLogger()

protocol AdBannerVMType {
    func getSpecificAd() -> Observable<Result<AdModel, FirebaseFetchError>>
    func saveSpecificAd() -> Observable<Result<AdModel, FirebaseStoreError>>
    func getBannerImgURL(filePath: String) -> Observable<URL?>
}

class AdBannerVM: BaseViewModel, AdBannerVMType {
    
    private let adService: AdServiceType!
    
    init(adService: AdServiceType) {
        self.adService = adService
        super.init()
    }
    
    func getSpecificAd() -> Observable<Result<AdModel, FirebaseFetchError>> {
        return self.adService
            .getSpecificAd()
            .trackActivity(loadingIndicator)
            .share(replay: 1)
    }
    
    func getBannerImgURL(filePath: String) -> Observable<URL?> {
        return self.adService
            .getBannerImgURL(filePath: filePath)
    }
    
    func saveSpecificAd() -> Observable<Result<AdModel, FirebaseStoreError>> {
        let imgURL = URL.init(string: "https://firebasestorage.googleapis.com/v0/b/logintest-7b011.appspot.com/o/Banners%2Fbanner.png?alt=media&token=05f17fb4-7a1d-4ac9-8f91-3bdf894768ca")
        let adURL = URL.init(string: "http://www.haydarkarkin.com")
        let adDic: [String: Any?] = ["imgURL": imgURL, "adURL": adURL]
        return self.adService.addAd(with: AdModel(form: adDic)!)
    }
}
