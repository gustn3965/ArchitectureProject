//
//  MovieSearchItem.swift
//  MovieNetwork
//
//  Created by 박현수 on 9/3/24.
//

import Foundation

public struct MovieListResponse: Decodable {
    let movieListResult: MovieListResult
}

public struct MovieListResult: Decodable {
    let totCnt: Int
    let source: String
    let movieList: [Movie]
}

public struct Movie: Decodable {
    let movieCd: String
    let movieNm: String
    let movieNmEn: String
    let prdtYear: String
    let openDt: String
    let typeNm: String
    let prdtStatNm: String
    let nationAlt: String
    let genreAlt: String
    let repNationNm: String
    let repGenreNm: String
}
