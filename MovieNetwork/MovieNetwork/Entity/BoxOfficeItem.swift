//
//  Movie.swift
//  MovieNetwork
//
//  Created by 박현수 on 8/6/24.
//

import Foundation

public struct BoxOfficeResult: Decodable {
    let boxofficeType: String
    let showRange: String
    let dailyBoxOfficeList: [BoxOfficeItem]
}

public struct BoxOfficeItem: Decodable, Equatable {
    let rnum: String
    public let rank: String
    let rankInten: String
    let rankOldAndNew: String
    public let movieCd: String
    public let movieTitle: String
    let openDt: String
    let salesAmt: String
    let salesShare: String
    let salesInten: String
    let salesChange: String
    let salesAcc: String
    let audiCnt: String
    let audiInten: String
    let audiChange: String
    public let audiAcc: String // 누적관객수 
    let scrnCnt: String
    let showCnt: String
    
    enum CodingKeys: String, CodingKey {
        case rnum
        case rank
        case rankInten = "rankInten"
        case rankOldAndNew = "rankOldAndNew"
        case movieCd = "movieCd"
        case movieTitle = "movieNm"  // JSON의 "movieNm" 키를 "movieTitle"로 매핑
        case openDt = "openDt"
        case salesAmt = "salesAmt"
        case salesShare = "salesShare"
        case salesInten = "salesInten"
        case salesChange = "salesChange"
        case salesAcc = "salesAcc"
        case audiCnt = "audiCnt"
        case audiInten = "audiInten"
        case audiChange = "audiChange"
        case audiAcc = "audiAcc"
        case scrnCnt = "scrnCnt"
        case showCnt = "showCnt"
    }
}

public struct BoxOfficeResponse: Decodable {
    let boxOfficeResult: BoxOfficeResult
}
