//
//  ApiCaller.swift
//  CryptoTracker
//
//  Created by Anang Nugraha on 21/09/21.
//

import Alamofire
import Foundation

protocol ApiCallerDelegate {
    func fetchAllCrypto(completion: @escaping (Result<[CryptoModel], Error>) -> Void)
}

struct ApiCaller: ApiCallerDelegate{
    
    private struct Constants {
        static let apiKey = "7098C520-8DDB-45C6-8F7B-441307ED3A08"
        static let baseUrl = "https://rest-sandbox.coinapi.io/v1/"
    }
    
    public func fetchAllCrypto(completion: @escaping (Result<[CryptoModel], Error>) -> Void){
        let url = "\(Constants.baseUrl)assets"
        let query: [String : String] = [
            "apikey" : "\(Constants.apiKey)"
        ]
        AF.request(url, method: .get, parameters: query).responseDecodable(of: [CryptoModel].self) { response in
            switch response.result{
            case .success(let cryptoList):
                let sortedCrypto = cryptoList.sorted { first, second in
                    return first.priceUsd ?? 0 > second.priceUsd ?? 0
                }
                completion(.success(sortedCrypto))
                print(cryptoList.count)
            case .failure(let error):
                completion(.failure(error))
                print(error.localizedDescription)
            }
        }
        
    }
    
}
