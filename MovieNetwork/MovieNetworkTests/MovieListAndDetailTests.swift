//
//  MovieListAndDetailTests.swift
//  MovieNetworkTests
//
//  Created by 박현수 on 8/8/24.
//

import XCTest
import Combine
@testable import MovieNetwork

final class MovieListAndDetailTests: XCTestCase {

    var cancellable = Set<AnyCancellable>()
    

    func test_KOBIS무비리스트응답정보로_TMDB영화상세정보가져온다() throws {
        
        let mockKobisSession = MockKOBISSession(mockJson: kobisMock)
        let movieRepo = MovieListRepository(network: DefaultNetwork(session: mockKobisSession))
        
        let mockTMDBSession = MockTMDBSession(jsonString: tmdbMock)
        let movieDetailRepo = MovieDetailRepository(network: DefaultNetwork(session: mockTMDBSession))
        
        performAsyncTest { expect in
            movieRepo.getMovieList()
                .sink { response in
                    switch response {
                    case .finished:
                        print()
                    case .failure(let error):
                        expect.fulfill()
                        print(error)
                        XCTFail()
                    }
                } receiveValue: { movies in

                    guard let title = movies.first?.movieTitle else {
                        expect.fulfill()
                        XCTFail()
                        return }
                    
                    movieDetailRepo.getDetailMovie(movieTitle: title)
                        .sink { response in
                            switch response {
                            case .finished:
                                expect.fulfill()
                            case .failure(let _):
                                expect.fulfill()
                                XCTFail()
                            }
                        } receiveValue: { movieDetail in
                            print(movieDetail)
                            print()
                            print(movieDetail.moviePosterUrl)
                            XCTAssert(true)
                        }
                        .store(in: &self.cancellable)
                }
                .store(in: &self.cancellable)
        }
    }

    
    let kobisMock = """
            {
                "boxOfficeResult": {
                    "boxofficeType": "일별 박스오피스",
                    "showRange": "20240803~20240803",
                    "dailyBoxOfficeList": [
                        {
                            "rnum": "1",
                            "rank": "1",
                            "rankInten": "0",
                            "rankOldAndNew": "OLD",
                            "movieCd": "20224666",
                            "movieNm": "파일럿",
                            "openDt": "2024-07-31",
                            "salesAmt": "4176611672",
                            "salesShare": "54.2",
                            "salesInten": "1830329721",
                            "salesChange": "78",
                            "salesAcc": "11989684606",
                            "audiCnt": "441583",
                            "audiInten": "192392",
                            "audiChange": "77.2",
                            "audiAcc": "1339825",
                            "scrnCnt": "1954",
                            "showCnt": "9561"
                        }]
                    }
                }
            """
    
    let tmdbMock = """
    {
        "page": 1,
        "results": [
            {
                "adult": false,
                "backdrop_path": "/1ApRLGSJ9ShDP1dUMAJQWbWBALz.jpg",
                "genre_ids": [
                    28,
                    18
                ],
                "id": 921436,
                "original_language": "ko",
                "original_title": "탈주",
                "overview": "After completing his required decade of military service...",
                "popularity": 14.308,
                "poster_path": "/kljqsaQIJHTtHpyP2F8W22bAovA.jpg",
                "release_date": "2024-07-03",
                "title": "Escape",
                "video": false,
                "vote_average": 7.7,
                "vote_count": 3
            }
        ],
        "total_pages": 1,
        "total_results": 11
    }
    """
    
}
