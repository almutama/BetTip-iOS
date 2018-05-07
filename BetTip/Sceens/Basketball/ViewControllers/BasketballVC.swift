//
//  BasketballViewController.swift
//  BetTip
//
//  Created by Haydar Karkin on 21.11.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import VegaScrollFlowLayout
import GoogleMobileAds

class BasketballVC: BaseViewController {
    
    var viewModel: BasketballVMType!
    private let disposeBag = DisposeBag()
    private let isLoading = Variable<Bool>(false)
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var bannerContainer: UIView!
    @IBOutlet weak var bannerContainerTop: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareUI()
        self.bindViewModel()
        self.configureBanner()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func prepareUI() {
        self.navigationItem.title = "FIRSAT BAHİS"
        let layout = VegaScrollFlowLayout()
        layout.itemSize = CGSize(width: collectionView.frame.width-20, height: 100)
        self.collectionView.collectionViewLayout =  layout
        self.collectionView.registerCellNib(BasketballCell.self)
    }
    
    func bindViewModel() {
        self.bindAnimateWith(variable: self.isLoading)
            .disposed(by: disposeBag)
        
        let matches = self.viewModel.getBasketballMatches()
            .asObservable()
            .delaySubscription(0, scheduler: MainScheduler.instance)
            .trackActivity(loadingIndicator)
            .share(replay: 1)
        
        matches.map { _ in false }.startWith(true)
            .catchErrorJustReturn(false)
            .bind(to: self.isLoading)
            .disposed(by: disposeBag)
        
        matches.bind(to: self.collectionView.rx.items(cellIdentifier: BasketballCell.reuseIdentifier,
                                                   cellType: BasketballCell.self)) { _, data, cell in
                cell.viewModel = Variable<MatchModel>(data)
            }.disposed(by: disposeBag)
    }
    
    private func configureBanner() {
        let bannerView = GADBannerView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50))
        bannerView.adUnitID = Constants.bannerAdUnitID
        bannerView.rootViewController = self
        
        let request = GADRequest()
        request.testDevices = [kGADSimulatorID]
        bannerView.load(request)
        
        self.bannerContainer.addSubview(bannerView)
        
        self.bannerContainerTop.constant = -50
        self.view.layoutIfNeeded()
        
        bannerView.rx.didReceiveAd.subscribe(
            onNext: { [weak self] _ in
                UIView.animate(withDuration: 0.5) {
                    guard self != nil else { return }
                    
                    self?.bannerContainerTop.constant = 0
                    self?.view.layoutIfNeeded()
                }
        }).disposed(by: self.disposeBag)
    }
}

extension BasketballVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 100)
    }
}
