//
//  AdBannerView.swift
//  BetTip
//
//  Created by Haydar Karkin on 20.05.2018.
//  Copyright © 2018 Haydar Karkin. All rights reserved.
//

import UIKit
import RxSwift
import Kingfisher

private let logger = Log.createLogger()

protocol AdBannerViewType {
    func initWithFrame(frame: CGRect)
    func bindViewModel()
    func showBanner(initComplete: @escaping (Bool) -> Void)
    func getView() -> AdBannerView
}

class AdBannerView: NibView, AdBannerViewType {
    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var openAdButton: UIButton!
    
    var viewModel: AdBannerVMType!
    private let disposeBag = DisposeBag()
    private var adURL: URL?
    
    init(viewModel: AdBannerVMType) {
        super.init()
        self.viewModel = viewModel
        self.bindViewModel()
    }
    
    required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder) }
    
    func initWithFrame(frame: CGRect) {
        self.frame = frame
    }
    
    func getView() -> AdBannerView {
        return self
    }
    
    func bindViewModel() {
        self.openAdButton.rx.tap.subscribe(onNext: {
            if let url = self.adURL {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }).disposed(by: disposeBag)
    }
    
    func saveSpecificAd() {
        self.viewModel.saveSpecificAd()
            .asObservable()
            .map { $0.value }
            .subscribe { event in
                switch event {
                case .next(let result):
                    logger.log(.debug, "Saving ad result: \(String(describing: result))")
                case .error(let error):
                    logger.log(.error, "Error occured when saving ad: \(error)")
                case .completed:
                    logger.log(.debug, "Saving ad completed!")
                }
            }
            .disposed(by: disposeBag)
    }
    
    func showSpecificAd(initComplete: @escaping (AdModel?) -> Void) {
        self.viewModel.getSpecificAd()
            .asObservable()
            .map { $0.value }
            .subscribe { event in
                switch event {
                case .next(let result):
                    logger.log(.debug, "Getting ad result: \(String(describing: result))")
                    initComplete(result)
                case .error(let error):
                    logger.log(.error, "Error occured when getting ad: \(error)")
                case .completed:
                    logger.log(.debug, "Getting ad completed!")
                }
            }
            .disposed(by: disposeBag)
    }
    
    func showBanner(initComplete: @escaping (Bool) -> Void) {
        self.showSpecificAd { result in
            guard let adModel = result else { return }
            print("adModel: \(adModel)")
            guard let imgURL = adModel.imgURL, let adURL = adModel.adURL else { return }
            self.adURL = adURL
            
            self.bannerImageView.kf.setImage(with: imgURL) { (img, error, url, data) in
                print(error?.localizedDescription ?? "")
                print(img?.accessibilityIdentifier ?? "test")
                if img != nil {
                    initComplete(true)
                } else {
                    initComplete(false)
                }
            }
        }
    }
}
