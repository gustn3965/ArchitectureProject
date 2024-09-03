//
//  MovieListView.swift
//  MovieTCA
//
//  Created by 박현수 on 8/6/24.
//

import SwiftUI
import ComposableArchitecture
import MovieNetwork

struct MovieListView: View {

    var store: StoreOf<MovieListFeature>
    
    var body: some View {
        VStack {
            if store.isLoading {
                ProgressView()
            } else {
                List(store.movieList, id: \.movieCd) { movie in
                    ListItem(model: ListItem.Model(model: movie))
                        .onTapGesture {
                            store.send(.showDetailMovie(movie))
                        }
                }
            }
        }.onAppear {
            if store.movieList.isEmpty {
                store.send(.start)
            }
        }
        .navigationTitle("Movie List")
        
//        WithViewStore(self.store, observe: { $0 }) { viewStore in
//            VStack {
//                if viewStore.isLoading {
//                    ProgressView()
//                } else {
//                    List(viewStore.movieList, id: \.movieCd) { movie in
//                        ListItem(model: ListItem.Model(model: movie))
//                            .onTapGesture {
//                                viewStore.send(.showDetailMovie(movie))
//                            }
//                    }
//                }   
//            }.onAppear {
//                store.send(.start)
//            }
//        }
    }
}

public struct ListItem: View {
    private let model: Self.Model
    
    public init(model: Self.Model) {
        self.model = model
    }
    
    public var body: some SwiftUI.View {
        HStack(spacing: 8) {
            VStack(spacing: 8) {
                HStack(spacing: .zero) {
                    Text(model.title)
                        .lineLimit(2)
                        .font(.system(size: 15))
                    Spacer()
                }
                HStack(spacing: .zero) {
                    Text("랭크: \(model.rank)")
                        .lineLimit(3)
                        .font(.system(size: 11))
                    Spacer()
                }
                HStack(spacing: .zero) {
                    Text("랭크: \(model.rank)")
                        .lineLimit(3)
                        .font(.system(size: 11))
                    Spacer()
                }
                HStack(spacing: .zero) {
                    Text("누적관객수: \(model.audience)")
                        .lineLimit(3)
                        .font(.system(size: 11))
                    Spacer()
                }
            }
        }
    }
}

extension ListItem {
    
    public struct Model {
        
        let title: String
        let rank: String
        let audience: String
        
        public init(model: MovieListItem) {
            title = model.movieTitle
            rank = model.rank
            audience = model.audiAcc
        }
    }
}
//#Preview {
//    ContentView()
//}
