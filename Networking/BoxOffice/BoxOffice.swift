//
//  BoxOffice.swift
//  Networking
//
//  Created by 전민돌 on 1/20/26.
//

import Foundation

struct BoxOfficeResponse: Decodable {
    let boxOfficeResult: BoxOfficeResult
}
 
struct BoxOfficeResult: Decodable {
    let boxofficeType: String
    let showRange: String
    let dailyBoxOfficeList: [DailyBoxOffice]
}
 
struct DailyBoxOffice: Decodable {
    let rank: String                // 해당일자의 박스오피스 순위
    let movieNm: String             // 영화명(국문)
    let openDt: String              // 영화의 개봉일
}
