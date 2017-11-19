//
//  BaseViewModel.swift
//  BetTip
//
//  Created by Haydar Karkin on 19.11.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import UIKit
import RxSwift

class BaseViewModel: NSObject {
    private(set) var isLoading = Variable(false)
    var errorHandler: ((Error?) -> Void)?
    var completionHandler: (() -> Void)?
}
