//
//  MovieDetailTests.swift
//  MovieNetworkTests
//
//  Created by 박현수 on 8/8/24.
//

import XCTest
import Combine

@testable import MovieNetwork
final class MovieDetailTests: XCTestCase {

    var cancellable = Set<AnyCancellable>()
    
    func test_TMDB영화상세정보응답_MovieDetail로_디코딩가능하다() throws {
        let mockString = """
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
                },
                {
                    "adult": false,
                    "backdrop_path": null,
                    "genre_ids": [
                        18
                    ],
                    "id": 415367,
                    "original_language": "ko",
                    "original_title": "탈주",
                    "overview": "It intermittently captures a delicate moment of emotional breakdown...",
                    "popularity": 3.983,
                    "poster_path": "/7StFayxC0CHOAyVgzLrV8AGsba9.jpg",
                    "release_date": "2010-09-02",
                    "title": "Break Away",
                    "video": false,
                    "vote_average": 0.0,
                    "vote_count": 0
                }
            ],
            "total_pages": 1,
            "total_results": 11
        }
        """
        
        let mockSession = MockTMDBSession(jsonString: mockString)
        let network = DefaultNetwork(session: mockSession)
        let movieDetailRepo = MovieDetailRepository(network: network)
        
     
        performAsyncTest { expect in
            
            movieDetailRepo.getDetailMovie(movieTitle: "test")
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
    }
}

class MockTMDBSession: SessionProtocol {
    
    var jsonString: String
    
    init(jsonString: String) {
        self.jsonString = jsonString
    }
    
    func publisherForURL(for url: URL) -> AnyPublisher<(data: Data, response: URLResponse), URLError> {
        guard let jsonData = jsonString.data(using: .utf8) else {
            return Fail(error: URLError.init(.badURL)).eraseToAnyPublisher()
        }
        
        let response = URLResponse()
        
        return Just((data: jsonData, response: response))
            .setFailureType(to: URLError.self)
            .eraseToAnyPublisher()
            
    }
    
    
}
