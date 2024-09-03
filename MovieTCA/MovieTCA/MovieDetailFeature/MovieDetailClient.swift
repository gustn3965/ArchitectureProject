//
//  MovieDetailClient.swift
//  MovieTCA
//
//  Created by 박현수 on 9/2/24.
//

import Foundation
import MovieNetwork
import ComposableArchitecture

struct MovieDetailClient {
    
    var repository: MovieDetailRepositoryProtocol
    
    static var real: Self = MovieDetailClient(repository: MovieDetailRepository(network: DefaultNetwork(session: URLSession.shared)))
}


extension MovieDetailClient: DependencyKey {
    static var liveValue: MovieDetailClient {
        return Self.real
    }
}


extension DependencyValues {
    
    var movieDetailClient: MovieDetailClient {
        get { self[MovieDetailClient.self] }
        set { self[MovieDetailClient.self] = newValue }
    }
}
