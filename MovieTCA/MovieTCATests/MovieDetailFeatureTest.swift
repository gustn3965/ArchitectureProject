//
//  MovieDetailFeatureTest.swift
//  MovieTCATests
//
//  Created by 박현수 on 8/11/24.
//

import Foundation
@testable import MovieNetwork
@testable import MovieTCA
import ComposableArchitecture
import Combine
import XCTest

@MainActor
class MovieDetailFeatureTest: XCTestCase {
    
    func test_movieDetail요청하여_Action_start하면_Action_movieResponse로_movieDetail받을수있다() async {
        
        let expected = MovieDetailItem(
            adult: false,
            backdropPath: "/1ApRLGSJ9ShDP1dUMAJQWbWBALz.jpg",
            genreIds: [28, 18],
            id: 921436,
            originalLanguage: "ko",
            originalTitle: "탈주",
            overview: "After completing his required decade of military service...",
            popularity: 14.308,
            posterPath: "/kljqsaQIJHTtHpyP2F8W22bAovA.jpg",
            releaseDate: "2024-07-03",
            title: "Escape",
            video: false,
            voteAverage: 7.7,
            voteCount: 3
        )
        
        let movieEnvironment: MovieDetailEnvironment = MovieDetailEnvironment(movieDetailRepository: MovieDetailRepository(network: DefaultNetwork(session: MockMovieDetailSession.mockData())))
        let feature = MovieDetailFeature(movieTitle: "탈주", movieDetaileEnvironment: movieEnvironment)
        
        let store: TestStoreOf<MovieDetailFeature> = .init(initialState: .init()) {
            feature
        }
        
        await store.send(.start) {
            $0.isLoading = true
        }
        
        await store.receive(.movieResponse(.success(expected)), timeout: 2*NSEC_PER_SEC) {
            $0.isLoading = false
            $0.movie = expected
        }
    }
}


private class MockMovieDetailSession: SessionProtocol {
    
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
    
    func publisherForRequest(for request: URLRequest) -> AnyPublisher<(data: Data, response: URLResponse), URLError> {
        guard let jsonData = jsonString.data(using: .utf8) else {
            return Fail(error: URLError.init(.badURL)).eraseToAnyPublisher()
        }
        
        let response = URLResponse()
        
        return Just((data: jsonData, response: response))
            .setFailureType(to: URLError.self)
            .eraseToAnyPublisher()
    }
    

    static func mockData() -> MockMovieDetailSession {
        
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
                }
            ],
            "total_pages": 1,
            "total_results": 11
        }
        """
        
        return MockMovieDetailSession(jsonString: mockString)
    }
}
