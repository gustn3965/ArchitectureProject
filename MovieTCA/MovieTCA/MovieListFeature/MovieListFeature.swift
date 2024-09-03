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

@Reducer
public struct MovieListFeature {
    
//    let environment: MovieListEnvironment
//    
//    init(environment: MovieListEnvironment) {
//        self.environment = environment
//    }
    
    @ObservableState
    public struct State: Equatable {
        public var isLoading: Bool = false
        public var movieList: [MovieListItem] = []
    }
    
    public enum Action {
        case start
        case movieListResponse(Result<[MovieListItem], MError>)
        case showDetailMovie(MovieListItem)
        
        case delegate(Delegate)
        
        public enum Delegate {
            case showDetail(MovieListItem)
        }
    }
    
    @Dependency(\.movieListClient) var movieListClient
    
    public var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .start:
                state.isLoading = true
                
                return .publisher {
                    movieListClient
                        .movieListRepository
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
                
                return .run { send in
                    await send(.delegate(.showDetail(item)))
                }
            case .delegate(.showDetail(_)):
                return .none
            case .delegate:
                return .none
            }
        }
    }
    
    
}
