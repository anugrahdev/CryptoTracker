//
//  HomeViewModel.swift
//  CryptoTracker
//
//  Created by Anang Nugraha on 22/09/21.
//

import Foundation
import RxSwift
import RxCocoa

class HomeViewModel: BaseViewModel {
    
    var cryptos = BehaviorRelay<[CryptoModel]>(value: [])
    
    func fetchCryptos() {
        state.onNext(.loading)
        ApiCaller.shared.fetchAllCrypto { [weak self ]result in
            switch result{
            case .success(let cryptos):
                self?.state.onNext(.success)
                self?.cryptos.accept(cryptos)
            case .failure(let error):
                self?.state.onNext(.error)
                self?.error.onNext(error.localizedDescription)
            }
            self?.state.onNext(.finish)
        }
    }
    
    func configureCryptoCell(_ cell: CryptoTableViewCell, _ index: IndexPath) {
        cell.configure(cryptos.value[index.row])
    }
    
    var numberOfCyrptoItems: Int{
        return cryptos.value.count
    }
    
}
