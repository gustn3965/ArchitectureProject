//
//  AppView.swift
//  MovieTCA
//
//  Created by 박현수 on 8/12/24.
//

import Foundation
import SwiftUI
import ComposableArchitecture
import Combine
import MovieNetwork

public struct AppView: View {
    
    @Bindable var store: StoreOf<AppFeature>
    
    public var body: some View {
        
//        MovieListView(store: store.scope(state: \.movieList, action: \.movieList))
        
        NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
            VStack {
                Button("App Start") {
                    store.send(.startApp)
                }
            }
            .navigationTitle("App")
        } destination: { store in
            switch store.case {
            case .movieList(let movieStore):
                MovieListView(store: movieStore)
            case .movieDetail(let movieStore):
                MovieDetailView(store: movieStore)
            }
        }

        
    }
}
