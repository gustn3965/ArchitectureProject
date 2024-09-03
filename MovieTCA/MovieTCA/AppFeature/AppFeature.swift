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

    @ObservableState
    public struct State {
        var path = StackState<Path.State>()
    }
    
    public enum Action {
        case path(StackActionOf<Path>)
        case startApp
    }
    
    public var body: some ReducerOf<Self> {
        
        Reduce { state, action in
            switch action {
            case .startApp:
                state.path.append(.movieList(MovieListFeature.State()))
                return .none
            case .path(.element(id: let id, action: .movieList(.delegate(.showDetail(let item))))):
                state.path.append(.movieDetail(MovieDetailFeature.State(movieTitle: item.movieTitle)))
                return .none
            default:
                return .none
            }
        }
        .forEach(\.path, action: \.path)
    }
    
    
    @Reducer
    public enum Path {
        case movieList(MovieListFeature)
        case movieDetail(MovieDetailFeature)
    }
}
