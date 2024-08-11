//
//  MovieListFeature.swift
//  MovieTCA
//
//  Created by 박현수 on 8/8/24.
//

import Foundation
import ComposableArchitecture
import MovieNetwork
import Combine

public struct MovieListFeature: Reducer {
    
    let environment: MovieListEnvironment
    
    init(environment: MovieListEnvironment) {
        self.environment = environment
    }
    
    public struct State: Equatable {
        public var isLoading: Bool = false
        public var movieList: [MovieListItem]
    }
    
    public enum Action: Equatable {
        case start
        case movieListResponse(Result<[MovieListItem], MError>)
        case showDetailMovie(MovieListItem)
    }
    
    public var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .start:
                state.isLoading = true
                return .publisher {
                    environment.movieListRepository
                        .getMovieList()
                        .receive(on: DispatchQueue.main)
                        .map { Action.movieListResponse(.success($0))}
                        .catch { Just(Action.movieListResponse(.failure($0))) }
                }
                
            case .movieListResponse(let result):
                state.isLoading = false
                switch result {
                case .success(let items):
                    state.movieList = items
                    print(items)
                case .failure(let error):
                    print(error)
                }
                print(result)
                return .none
            case .showDetailMovie(let item):
                return .none
            }
        }
    }
    
    
}
