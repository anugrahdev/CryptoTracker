//
//  BaseViewModel.swift
//  CryptoTracker
//
//  Created by Anang Nugraha on 22/09/21.
//

import Foundation
import RxSwift
import RxCocoa

enum NetworkState {
    case initial
    case loading
    case finish
    case error
    case success
}

class BaseViewModel {
    
    let disposeBag  = DisposeBag()
    var state       = PublishSubject<NetworkState>()
    var hudeState   = PublishSubject<NetworkState>()
    var error       = PublishSubject<String>()
    var success     = PublishSubject<NetworkState>()
    
}
