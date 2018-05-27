//
//  FootballVC.swift
//  BetTip
//
//  Created by Haydar Karkin on 29.11.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import UIKit
import RxSwift
import GoogleMobileAds

class FootballVC: BaseViewController {
    
    var viewModel: FootballVMType!
    var bannerView: AdBannerViewType!
    private let disposeBag = DisposeBag()
    private let isLoading = Variable<Bool>(false)
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var bannerContainer: UIView!
    @IBOutlet weak var bannerContainerTop: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareUI()
        self.bindViewModel()
        self.showBanner()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func prepareUI() {
        self.navigationItem.title = "FIRSAT BAHİS"
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: collectionView.frame.width-20, height: 100)
        self.collectionView.collectionViewLayout =  layout
        self.collectionView.registerCellNib(FootballCell.self)
    }
    
    func bindViewModel() {
        self.bindAnimateWith(variable: self.isLoading)
            .disposed(by: disposeBag)
        
        let matches = self.viewModel.getFootballMatches()
            .asObservable()
            .delaySubscription(0, scheduler: MainScheduler.instance)
            .trackActivity(loadingIndicator)
            .share(replay: 1)
            .flatMap { value -> Observable<[MatchModel]> in
                let sortedList =  value.sorted(by: {(match1, match2) -> Bool in match1 << match2})
                return Observable.just(sortedList)
            }
        
        matches.map { _ in false }.startWith(true)
            .catchErrorJustReturn(false)
            .bind(to: self.isLoading)
            .disposed(by: disposeBag)
        
        matches.subscribe(onNext: { [weak self] _ in
            guard let strongSelf = self else { return }
            _ = Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { _ in
                strongSelf.showInterstitial()
            }
        }).disposed(by: disposeBag)
        
        self.viewModel.getProducts()
            .asObservable()
            .subscribe(onNext: { [weak self] products in
                guard self != nil else { return }
                print(products)
        }).disposed(by: disposeBag)
        
        matches.bind(to: self.collectionView.rx.items(cellIdentifier: FootballCell.reuseIdentifier,
                                                      cellType: FootballCell.self)) { _, data, cell in
                                                        cell.viewModel = Variable<MatchModel>(data)
            }.disposed(by: disposeBag)
    }

    
    private func showInterstitial() {
        let interstitial = GADInterstitial(adUnitID: Constants.interstitialAdUnitID)
        let request = GADRequest()
        request.testDevices = [kGADSimulatorID]
        interstitial.load(request)
        
        interstitial.rx.didReceiveAd.subscribe(
            onNext: { [weak self] _ in
                guard let strongSelf = self else { return }
                interstitial.present(fromRootViewController: strongSelf)
        }).disposed(by: self.disposeBag)
    }
    
    private func showBanner() {
        self.bannerView.initWithFrame(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50))
        self.bannerContainer.addSubview(self.bannerView.getView())
        
        self.bannerContainerTop.constant = -50
        self.view.layoutIfNeeded()
        
        self.bannerView.showBanner { result in
            if result == true {
                UIView.animate(withDuration: 0.5) {                    
                    self.bannerContainerTop.constant = 0
                    self.view.layoutIfNeeded()
                }
            }
        }
    }
}
