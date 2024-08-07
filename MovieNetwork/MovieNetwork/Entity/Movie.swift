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
    let dailyBoxOfficeList: [Movie]
}

public struct Movie: Decodable {
    let rnum: String
    let rank: String
    let rankInten: String
    let rankOldAndNew: String
    let movieCd: String
    let movieNm: String
    let openDt: String
    let salesAmt: String
    let salesShare: String
    let salesInten: String
    let salesChange: String
    let salesAcc: String
    let audiCnt: String
    let audiInten: String
    let audiChange: String
    let audiAcc: String
    let scrnCnt: String
    let showCnt: String
}

public struct BoxOfficeResponse: Decodable {
    let boxOfficeResult: BoxOfficeResult
}
