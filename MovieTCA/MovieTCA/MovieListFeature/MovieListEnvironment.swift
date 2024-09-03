//
//  MovieListEnvironment.swift
//  MovieTCA
//
//  Created by 박현수 on 8/8/24.
//

import Foundation
import MovieNetwork


// Deprecated
public struct MovieListEnvironment {
    public let movieListRepository: MovieListRepositoryProtocol
    
    public init(movieListRepository: MovieListRepositoryProtocol) {
        self.movieListRepository = movieListRepository
    }
}
