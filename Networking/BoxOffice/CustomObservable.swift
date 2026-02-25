//
//  CustomObservable.swift
//  Networking
//
//  Created by 전민돌 on 2/25/26.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire

enum BoxOfficeNetworkError: Error {
    case badRequest
    case unAuthorized
    case forbidden
    case notFound
    case serverError
    case noResponse
    case decodingError
    case unknown(statusCode: Int?)
    
    var description: String {
        switch self {
        case .badRequest:
            return "잘못된 요청입니다."
        case .unAuthorized:
            return "인증에 실패했습니다."
        case .forbidden:
            return "접근 권한이 없습니다."
        case .notFound:
            return "요청한 리소스를 찾을 수 없습니다."
        case .serverError:
            return "서버에서 오류가 발생했습니다."
        case .noResponse:
            return "서버에서의 응답이 없습니다."
        case .decodingError:
            return "디코딩에 실패했습니다."
        case .unknown(statusCode: let statusCode):
            return "알 수 없는 오류가 발생했습니다. (\(statusCode.map(String.init) ?? "no Code"))"
        }
    }
}

final class CustomObservable {
    static func singleBoxOfficeRequest(date: String) -> Single<Result<[DailyBoxOffice], BoxOfficeNetworkError>> {
        return Single.create { single -> Disposable in
            let url = "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=3d21e6069bf78850c738916d85c1cbe0&targetDt=\(date)"
            
            AF.request(url, method: .get).validate(statusCode: 200..<300).responseDecodable(of: BoxOfficeResponse.self) { response in
                guard let statusCode = response.response?.statusCode else {
                    single(.success(.failure(.noResponse)))
                    return
                }
                
                switch response.result {
                case .success(let value):
                    single(.success(.success(value.boxOfficeResult.dailyBoxOfficeList)))
                    
                case .failure(_):
                    let networkError: BoxOfficeNetworkError
                    
                    switch statusCode {
                    case 400:
                        networkError = .badRequest
                    case 401:
                        networkError = .unAuthorized
                    case 403:
                        networkError = .forbidden
                    case 404:
                        networkError = .notFound
                    case 500...599:
                        networkError = .serverError
                    default:
                        networkError = .unknown(statusCode: statusCode)
                    }
                    
                    single(.success(.failure(networkError)))
                }
            }
            return Disposables.create()
        }
    }
}
