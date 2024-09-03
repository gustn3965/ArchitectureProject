//
//  MovieListClient.swift
//  MovieTCA
//
//  Created by 박현수 on 9/2/24.
//

import Foundation
import Combine
import ComposableArchitecture
import MovieNetwork

struct MovieListClient {

    // function으로 하게되면..주입을 못받는구나,
    var movieListRepository: MovieListRepositoryProtocol
    
    static var real: MovieListClient = MovieListClient(movieListRepository:
                                                        MovieListRepository(network: DefaultNetwork(session: URLSession.shared)))
}

extension MovieListClient: DependencyKey {
    
    static var liveValue: MovieListClient {
        return MovieListClient.real
    }
}

extension DependencyValues {
    
    var movieListClient: MovieListClient {
        get { self[MovieListClient.self] }
        set { self[MovieListClient.self] = newValue }
    }
}
