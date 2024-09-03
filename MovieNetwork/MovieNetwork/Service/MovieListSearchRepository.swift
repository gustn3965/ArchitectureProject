//
//  MovieListSearchRepository.swift
//  MovieNetwork
//
//  Created by 박현수 on 9/3/24.
//

import Foundation
import Combine

public protocol MovieListSearchRepositoryProtocol {
    
    func searchMovie(name: String) -> AnyPublisher<[Movie], MError>
}

public class MovieListSearchRepository: MovieListSearchRepositoryProtocol {
    
    var network: NetworkProtocol
    
    public init(network: NetworkProtocol) {
        self.network = network
    }
    
    public func searchMovie(name: String) -> AnyPublisher<[Movie], MError> {
        let anyPulbisher: AnyPublisher<MovieListResponse, MError> = network.requestURLRequest(endpoint: MovieEndpoint.movieList(name))
        
        return anyPulbisher
            .delay(for: .seconds(1), scheduler: DispatchQueue.main)
            .map { response in
                return response.movieListResult.movieList
            }
            .eraseToAnyPublisher()
    }
}
