//
//  HomeViewModelTests.swift
//  CryptoTrackerTests
//
//  Created by Anang Nugraha on 24/09/21.
//

import XCTest
@testable import CryptoTracker

class HomeViewModelTests: XCTestCase {

    var viewModel: HomeViewModel!
    var apiCaller: MockApiCaller!
    
    override func setUp() {
        apiCaller = MockApiCaller()
        viewModel = .init(service: apiCaller)
    }
    
    func testFetchCryptosWithResultSuccess() {
        apiCaller.result = .success([])
        viewModel.fetchCryptos()
        
        XCTAssertEqual(viewModel.fetchState, .success)
    }
    
    func testFetchCryptosWithResultError() {
        apiCaller.result = .failure(NSError(domain: "", code: -1, userInfo: nil))
        viewModel.fetchCryptos()
        
        XCTAssertEqual(viewModel.fetchState, .error)
    }

}
