//
//  MovieListSearchTests.swift
//  MovieNetworkTests
//
//  Created by 박현수 on 9/3/24.
//

import Foundation
import XCTest
import Combine

@testable import MovieNetwork

class MovieListSearchTests: XCTestCase {

    var cancellable = Set<AnyCancellable>()
    
    func test_KOBIS영화목록검색_Movie로_decoding가능하다() {
        let jsonData = """
        {
            "movieListResult": {
                "totCnt": 39,
                "source": "영화진흥위원회",
                "movieList": [
                    {
                        "movieCd": "20219857",
                        "movieNm": "인디애니페스트2021 새벽비행1",
                        "movieNmEn": "First Flight1",
                        "prdtYear": "2021",
                        "openDt": "",
                        "typeNm": "옴니버스",
                        "prdtStatNm": "기타",
                        "nationAlt": "한국",
                        "genreAlt": "애니메이션",
                        "repNationNm": "한국",
                        "repGenreNm": "애니메이션",
                        "directors": [],
                        "companys": []
                    }
                ]
            }
        }
        """
        
        let mockSession = MockKOBISSession(mockJson: jsonData)
        
        let movieRepo = MovieListSearchRepository(network: DefaultNetwork(session: mockSession))
        
        performAsyncTest { expectation in
            movieRepo.searchMovie(name: "에일리언")
                .sink { response in
                    switch response {
                    case .finished:
                        expectation.fulfill()
                    case .failure(let error):
                        expectation.fulfill()
                        print(error)
                        XCTFail()
                    }
                } receiveValue: { movies in
                    print(movies)
                    print()
                    print(movies.first?.movieNm)
                    XCTAssertTrue(true)
                }
                .store(in: &self.cancellable)
        }
        
    }
}
