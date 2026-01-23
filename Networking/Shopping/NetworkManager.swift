//
//  NetworkManager.swift
//  Networking
//
//  Created by 전민돌 on 1/21/26.
//

import Foundation
import Alamofire

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {  }
    
    func callRequest<T: Decodable>(query: String, start: Int, sort: String, type: T.Type, success: @escaping (T) -> Void) {
        let url = "https://openapi.naver.com/v1/search/shop.json"
        let headers: HTTPHeaders = ["X-Naver-Client-Id":APIKey.clientID, "X-Naver-Client-Secret":APIKey.secretID]
        let parameters: Parameters = ["query":query, "display":"30", "start":start, "sort":sort]
        
        AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.queryString, headers: headers)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let value):
                    dump(value)
                    success(value)
                case .failure(let error):
                    print(error)
                }
            }
    }
}
