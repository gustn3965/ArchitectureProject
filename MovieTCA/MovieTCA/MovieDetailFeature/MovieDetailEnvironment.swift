//
//  MovieDetailEnvironment.swift
//  MovieTCA
//
//  Created by 박현수 on 8/11/24.
//

import Foundation
import MovieNetwork

public struct MovieDetailEnvironment {
    public let movieDetailRepository: MovieDetailRepositoryProtocol
    
    public init(movieDetailRepository: MovieDetailRepositoryProtocol) {
        self.movieDetailRepository = movieDetailRepository
    }
}
