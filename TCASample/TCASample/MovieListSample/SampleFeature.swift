//
//  SampleFeature.swift
//  TCASample
//
//  Created by 박현수 on 9/2/24.
//

import Foundation
import ComposableArchitecture

@Reducer
struct MovieListFeature {
    
    @ObservableState
    struct State {
        var movie: [Movie]
        
        @Presents var movieDetail: MovieDetailFeature.State?

    }
    
    enum Action {
        case fetchMovie
        case movieResponse([Movie])
        
        case clickMovieDetial(Movie)
        case movieDetail(PresentationAction<MovieDetailFeature.Action>)
    }
    
    @Dependency(\.movieListClient) var movieListClient
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .fetchMovie:
                                
                return .run { send in
                    let newMovie = try await movieListClient.fetch()
                    
                    await send(.movieResponse(newMovie))
                }

            case .movieResponse(let newMovies):
                state.movie = newMovies
                return .none
                
            case .clickMovieDetial(let movie):
                state.movieDetail = MovieDetailFeature.State(movie: movie)
                return .none
            case .movieDetail:
                return .none
            }
        }.ifLet(\.$movieDetail, action: \.movieDetail) {
            MovieDetailFeature()
        }
    }
}

struct Movie: Identifiable {
    var id = UUID()
    var name: String
}


@Reducer
struct MovieDetailFeature {
    @ObservableState
    struct State {
        var movie: Movie
    }
    
    enum Action {
        case bookingMovie
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .bookingMovie:
                return .none
            }
        }
    }
}

import SwiftUI

struct MovieListView: View  {
    
    @Bindable var store: StoreOf<MovieListFeature>
    
    var body: some View {
        
        VStack {
            List {
                ForEach(store.movie) { movie in
                    HStack {
                        Text(movie.name)
                        Button("Movie Detail") {
                            store.send(.clickMovieDetial(movie))
                        }
                    }
                }
            }
            
            Button("fetch Movie") {
                store.send(.fetchMovie)
            }
        }
        .sheet(item: $store.scope(state: \.movieDetail, action: \.movieDetail)) { store in
            MovieDetailView(store: store)
        }
    }
}
struct MovieDetailView: View  {
    
    var store: StoreOf<MovieDetailFeature>
    
    var body: some View {
        
        Text(store.movie.name)
    }
}

struct MovieListClient {
    var fetch: () async throws -> [Movie]
    
    static var mock: MovieListClient = MovieListClient(fetch: {
            [Movie(name: "베테랑"), Movie(name: "에일리언")]
        })
    
    static var real: MovieListClient = MovieListClient {
        let (data, _) = try await URLSession.shared.data(from: URL(string: "movie")!)
        let newMovie = [Movie(name: "리얼")]
        return newMovie
    }
}

extension MovieListClient: DependencyKey {
    static var liveValue: MovieListClient = Self.real
}

extension DependencyValues {
    var movieListClient: MovieListClient {
        get { self[MovieListClient.self] }
        set { self[MovieListClient.self] = newValue }
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
                .dependency(\.movieListClient, .real)
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
