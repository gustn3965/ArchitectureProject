//
//  MovieTCAApp.swift
//  MovieTCA
//
//  Created by 박현수 on 8/6/24.
//

import SwiftUI
import MovieNetwork

@main
struct MovieTCAApp: App {
    var body: some Scene {
        WindowGroup {
            AppView(store: .init(initialState: AppFeature.State(movieListState: MovieListFeature.State(movieList: [])),
                                 reducer: {
                AppFeature()
            }))
            
            
            
//            MovieListView(store: .init(
//                initialState: MovieListFeature.State(movieList: []),
//                reducer: {
//                    MovieListFeature(environment: .init(
//                        movieListRepository: MovieListRepository(
//                            network: DefaultNetwork(session: URLSession.shared)
//                        )
//                    ))
//                }
//            ))
//            MovieDetailView(store: .init(initialState: MovieDetailFeature.State(),
//                                         reducer: {
//                MovieDetailFeature(movieTitle: "탈주",
//                                   movieDetaileEnvironment:
//                                    MovieDetailEnvironment(movieDetailRepository: MovieDetailRepository(network: DefaultNetwork(session: URLSession.shared))))
//            }))
        }
    }
}
