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
import GoogleMobileAds

class BasketballVC: BaseViewController {
    
    var viewModel: BasketballVMType!
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
        self.navigationItem.title = L10n.Common.title
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: collectionView.frame.width-20, height: 100)
        self.collectionView.collectionViewLayout =  layout
        self.collectionView.registerCellNib(MainMatchCell.self)
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
        
        matches.bind(to: self.collectionView.rx.items(cellIdentifier: MainMatchCell.reuseIdentifier,
                                                   cellType: MainMatchCell.self)) { _, data, cell in
                cell.viewModel = Variable<MatchModel>(data)
            }.disposed(by: disposeBag)
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
