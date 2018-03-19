//
//  UICollectionView+Ext.swift
//  BetTip
//
//  Created by Haydar Karkin on 18.11.2017.
//  Copyright © 2017 Haydar Karkin. All rights reserved.
//

import UIKit

extension UICollectionView {
    func registerCellNib(_ cellClass: AnyClass) {
        let identifier = String.className(cellClass)
        let nib = UINib(nibName: identifier, bundle: nil)
        self.register(nib, forCellWithReuseIdentifier: identifier)
    }
    
    func registerReusableHeaderNib<T: UICollectionReusableView>(_: T.Type) where T: Reusable {
        let nib = UINib(nibName: T.reuseIdentifier, bundle: nil)
        self.register(nib, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: T.reuseIdentifier)
    }
    
    func registerReusableHeaderView<T: UICollectionReusableView>(_: T.Type) where T: Reusable {
        if let nib = T.nib {
            self.register(nib, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: T.reuseIdentifier)
        } else {
            self.register(T.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: T.reuseIdentifier)
        }
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(indexPath: IndexPath) -> T where T: Reusable {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not deque table cell")
        }
        return cell
    }
    
    func dequeueReusableHeader<T: UICollectionReusableView>(indexPath: IndexPath) -> T where T: Reusable {
        guard let cell = self.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not deque table header cell")
        }
        return cell
    }
}
