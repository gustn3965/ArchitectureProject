//
//  MovieListFeatureTest.swift
//  MovieTCATests
//
//  Created by 박현수 on 8/11/24.
//


import XCTest
import ComposableArchitecture
import Combine 
@testable import MovieNetwork
@testable import MovieTCA

@MainActor
class MovieListFeatureTest: XCTestCase {
//    
    func test_mockKOBISSession을이용하여_Action_start를보내면_Action_movieListResponse로받아와_movie를_받아올수있다() async {
        
        let expectedMovieListItems = [
            MovieListItem(
                rnum: "1",
                rank: "1",
                rankInten: "0",
                rankOldAndNew: "OLD",
                movieCd: "20224666",
                movieTitle: "파일럿",
                openDt: "2024-07-31",
                salesAmt: "4176611672",
                salesShare: "54.2",
                salesInten: "1830329721",
                salesChange: "78",
                salesAcc: "11989684606",
                audiCnt: "441583",
                audiInten: "192392",
                audiChange: "77.2",
                audiAcc: "1339825",
                scrnCnt: "1954",
                showCnt: "9561"
            )
        ]
        
        let mockSession = MockKOBISSession.initWithMockJson()
        
        let store = TestStore(initialState: MovieListFeature.State()) {
            MovieListFeature()
        } withDependencies: { dependency in
            dependency.movieListClient = MovieListClient(movieListRepository: MovieListRepository(network: DefaultNetwork(session: mockSession)))
            
        }

        
        await store.send(MovieListFeature.Action.start) {
            $0.isLoading = true
        }
        
        await store.receive(\.movieListResponse.success, timeout: 2*NSEC_PER_SEC) {
            $0.isLoading = false
            $0.movieList = expectedMovieListItems
        }
//        await store.receive(\.movieListResponse.success(expectedMovieListItems))
        
//        await store.receive(.movieListResponse(.success(expectedMovieListItems)), timeout: 2*NSEC_PER_SEC) {
//            $0.isLoading = false
//            $0.movieList = expectedMovieListItems
//        }
    }
}

private class MockKOBISSession: SessionProtocol {

    
    var mockJson: String
    
    static func initWithMockJson() -> MockKOBISSession {
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
        return MockKOBISSession(mockJson: jsonData)
    }
    
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
    
    func publisherForRequest(for request: URLRequest) -> AnyPublisher<(data: Data, response: URLResponse), URLError> {
        guard let jsonData = mockJson.data(using: .utf8) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        let response = URLResponse()
        return Just((data: jsonData, response: response))
            .setFailureType(to: URLError.self)
            .eraseToAnyPublisher()
    }
    
}

