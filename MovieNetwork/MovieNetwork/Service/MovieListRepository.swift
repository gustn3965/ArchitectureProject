//
//  MovieListRepository.swift
//  MovieNetwork
//
//  Created by 박현수 on 8/6/24.
//

import Foundation
import Combine

protocol MovieListRepositoryProtocol {
    
    func getMovieList() -> AnyPublisher<[MovieListItem], MError>
}

public class MovieListRepository: MovieListRepositoryProtocol {
    
    var network: NetworkProtocol
    
    public init(network: NetworkProtocol) {
        self.network = network
    }
    
    public func getMovieList() -> AnyPublisher<[MovieListItem], MError> {
        
        let anyPulbisher: AnyPublisher<BoxOfficeResponse, MError> = network.request(endpoint: MovieEndpoint.movieList)
        
        return anyPulbisher.map { response in
            return response.boxOfficeResult.dailyBoxOfficeList
        }
        .eraseToAnyPublisher()
    }
}


