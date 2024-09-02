//
//  BBFeature.swift
//  TCASample
//
//  Created by 박현수 on 8/30/24.
//

import ComposableArchitecture
import Foundation

@Reducer
struct OrangeFeature {
    
    @ObservableState
    struct State {
        
    }
    
    enum Action {
        case clickBackButton
    }
    
    @Dependency(\.dismiss) var dismiss
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .clickBackButton:
                
                return .run { _ in
                    await self.dismiss()
                }
            }
        }
    }
}


@Reducer
struct AppFeature {
    @ObservableState
    struct State {
        var movieList: MovieListFeature.State?
    }
    
    enum Action {
        case movieList(MovieListFeature.Action)
        case appStart
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            
            switch action {
            case .appStart:
                state.movieList = MovieListFeature.State(movie: [])
                return .none
            case .movieList:
                return .none
            }
        }.ifLet(\.movieList, action: \.movieList) {
            MovieListFeature()
        }
//        
//        Scope(state: \.movieList, action: \.movieList) {
//            MovieListFeature()
//        }
    }
}

struct AppView: View {
    
    var store: StoreOf<AppFeature>
    
    var body: some View {
        
        VStack {
            
            if let movieListStore = store.scope(state: \.movieList, action: \.movieList) {
                MovieListView(store: movieListStore)
            } else {
                VStack {
                    Text("App View")
                    Button("app Start") {
                        store.send(.appStart)
                    }
                }
                
            }
        }
    }
}
