//
//  MovieListRepository.swift
//  MovieNetwork
//
//  Created by 박현수 on 8/6/24.
//

import Foundation
import Combine

public protocol MovieBoxOfficeRepositoryProtocol {
    
    func getMovieList() -> AnyPublisher<[BoxOfficeItem], MError>
}

public class MovieBoxOfficeRepository: MovieBoxOfficeRepositoryProtocol {
    
    var network: NetworkProtocol
    
    public init(network: NetworkProtocol) {
        self.network = network
    }
    
    public func getMovieList() -> AnyPublisher<[BoxOfficeItem], MError> {
        
        let anyPulbisher: AnyPublisher<BoxOfficeResponse, MError> = network.requestURLRequest(endpoint: MovieEndpoint.boxOffice)
        
        return anyPulbisher
            .delay(for: .seconds(1), scheduler: DispatchQueue.main)
            .map { response in
            return response.boxOfficeResult.dailyBoxOfficeList
        }
        .eraseToAnyPublisher()
    }
}


