//
//  MockApiCaller.swift
//  CryptoTrackerTests
//
//  Created by Anang Nugraha on 24/09/21.
//

import Foundation
@testable import CryptoTracker

class MockApiCaller: ApiCallerDelegate {
    
    var result: Result<[CryptoModel], Error> = .success([])
    
    func fetchAllCrypto(completion: @escaping (Result<[CryptoModel], Error>) -> Void) {
        completion(result)
    }

}
