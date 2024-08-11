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
            MovieListView(store: .init(
                initialState: MovieListFeature.State(movieList: []),
                reducer: {
                    MovieListFeature(environment: .init(
                        movieListRepository: MovieListRepository(
                            network: DefaultNetwork(session: URLSession.shared)
                        )
                    ))
                }
            ))
        }
    }
}
