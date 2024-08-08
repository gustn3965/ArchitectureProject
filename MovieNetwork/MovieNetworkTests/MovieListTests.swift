//
//  MovieNetworkTests.swift
//  MovieNetworkTests
//
//  Created by 박현수 on 8/6/24.
//

import XCTest
import Combine

@testable import MovieNetwork

final class MovieListTests: XCTestCase {
    
    var cancellable = Set<AnyCancellable>()
    
    func test_KOBIS일별박스오피스응답_Movie디코딩_가능하다() throws {
        
        let jsonData = """
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
        let mockSession = MockKOBISSession(mockJson: jsonData)
        
        let movieRepo = MovieListRepository(network: DefaultNetwork(session: mockSession))
        
        performAsyncTest { expectation in
            movieRepo.getMovieList()
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
                    print(movies.first?.movieTitle)
                    XCTAssertTrue(true)
                }
                .store(in: &self.cancellable)
        }
    }
}


class MockKOBISSession: SessionProtocol {
    
    var mockJson: String
    
    init(mockJson: String) {
        self.mockJson = mockJson
    }
    
    func publisherForURL(for url: URL) -> AnyPublisher<(data: Data, response: URLResponse), URLError> {
        guard let jsonData = mockJson.data(using: .utf8) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        let response = URLResponse()
        return Just((data: jsonData, response: response))
            .setFailureType(to: URLError.self)
            .eraseToAnyPublisher()
    }
}
