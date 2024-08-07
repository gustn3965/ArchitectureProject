//
//  MovieListRepository.swift
//  MovieNetwork
//
//  Created by 박현수 on 8/6/24.
//

import Foundation
import Combine

protocol MovieListNetworkProtocol {
    
    func getMovieList() -> AnyPublisher<[Movie], MError>
}

public class MovieListRepository {
    
    var network: NetworkProtocol
    
    public init(network: NetworkProtocol) {
        self.network = network
    }
    
    public func getMovieList() -> AnyPublisher<[Movie], MError> {
        
        let anyPulbisher: AnyPublisher<BoxOfficeResponse, MError> = network.request(endpoint: MovieEndpoint.movieList)
        
        return anyPulbisher.map { response in
            return response.boxOfficeResult.dailyBoxOfficeList
        }
        .eraseToAnyPublisher()
    }
}


