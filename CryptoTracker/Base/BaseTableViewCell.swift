//
//  BaseTableViewCell.swift
//  CryptoTracker
//
//  Created by Anang Nugraha on 21/09/21.
//

import Foundation
import UIKit
import RxSwift

public class BaseTableViewCell: UITableViewCell {
    public var disposeBag = DisposeBag()
    
}

extension BaseTableViewCell: Reusable { }
