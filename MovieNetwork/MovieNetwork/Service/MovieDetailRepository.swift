//
//  MovieDetailRepository.swift
//  MovieNetwork
//
//  Created by 박현수 on 8/8/24.
//

import Foundation
import Combine

public protocol MovieDetailRepositoryProtocol {
    
    func getDetailMovie(movieTitle: String) -> AnyPublisher<MovieDetailItem, MError>
}

public class MovieDetailRepository: MovieDetailRepositoryProtocol {
    
    private var network: NetworkProtocol
    
    public init(network: NetworkProtocol) {
        self.network = network
    }
    
    public func getDetailMovie(movieTitle: String) -> AnyPublisher<MovieDetailItem, MError> {
    
        let publisher: AnyPublisher<MovieDetailResponse, MError> = network.requestURLRequest(endpoint: MovieEndpoint.movieDetail(movieTitle))
        
        return publisher
            .delay(for: .seconds(1), scheduler: DispatchQueue.main)
            .tryMap({ response in
                if let firstItem = response.results.first {
                    return firstItem
                } else {
                    throw MError.unexpectedError
                }
            })
            .mapError { error -> MError in
                // tryMap에서 발생한 에러를 MError로 변환
                return error as? MError ?? MError.unexpectedError
            }
            .eraseToAnyPublisher()
          
    }
}
