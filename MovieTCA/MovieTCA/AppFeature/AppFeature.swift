//
//  AppFeature.swift
//  MovieTCA
//
//  Created by 박현수 on 8/12/24.
//

import Foundation
import ComposableArchitecture
import MovieNetwork

@Reducer
public struct AppFeature {

    public struct State: Equatable {
        
        var movieListState: MovieListFeature.State
        
    }
    
    public enum Action: Equatable {
        
        case list(MovieListFeature.Action)
    }
    
    public var body: some Reducer<State, Action> {
        Scope(state: \.movieListState, 
              action: \.list) {
            MovieListFeature(environment: MovieListEnvironment(movieListRepository: MovieListRepository(network: DefaultNetwork(session: URLSession.shared))))
        }

        Reduce { state, action in
            switch action {
            case .list(.showDetailMovie(let item)):
                print(item)
                return .none
            default:
                return .none
            }
        }
    }
}
