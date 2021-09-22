//
//  HomeViewModel.swift
//  CryptoTracker
//
//  Created by Anang Nugraha on 22/09/21.
//

import Foundation
import RxSwift

class HomeViewModel: BaseViewModel {
    
    var cryptos = PublishSubject<[CryptoModel]>()
    
    func fetchCryptos() {
        state.onNext(.loading)
        ApiCaller.shared.fetchAllCrypto { [weak self ]result in
            switch result{
            case .success(let cryptos):
                self?.state.onNext(.success)
                self?.cryptos.onNext(cryptos)
            case .failure(let error):
                self?.state.onNext(.error)
                self?.error.onNext(error.localizedDescription)
            }
            self?.state.onNext(.finish)
        }
    }
    
}
