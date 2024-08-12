//
//  MovieDetailFeature.swift
//  MovieTCA
//
//  Created by 박현수 on 8/11/24.
//

import Foundation
import ComposableArchitecture
import MovieNetwork
import Combine

@Reducer
public struct MovieDetailFeature {
    
    private let movieTitle: String
    private let movieDetaileEnvironment: MovieDetailEnvironment
    
    public init(movieTitle: String, movieDetaileEnvironment: MovieDetailEnvironment) {
        self.movieTitle = movieTitle
        self.movieDetaileEnvironment = movieDetaileEnvironment
    }
    
    public struct State: Equatable {
        var isLoading: Bool = false
        var movie: MovieDetailItem?
    }
    
    public enum Action: Equatable {
        case start
        case movieResponse(Result<MovieDetailItem, MError>)
    }
    
    public var body: some Reducer<State, Action> {
        
        Reduce { state, action in
            switch action {
            case .start:
                state.isLoading = true
                return Effect.publisher {
                    movieDetaileEnvironment
                        .movieDetailRepository
                        .getDetailMovie(movieTitle: movieTitle)
                        .receive(on: DispatchQueue.main)
                        .map { Action.movieResponse(.success($0))}
                        .catch { Just(Action.movieResponse(.failure($0)))}
                }

            case .movieResponse(.success(let item)):
                state.isLoading = false
                state.movie = item
                return .none
            case .movieResponse(.failure(let error)):
                state.isLoading = false
                return .none
            }
        }
    }
}
