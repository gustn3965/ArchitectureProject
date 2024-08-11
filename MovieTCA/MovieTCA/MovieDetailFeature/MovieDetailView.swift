//
//  MovieDetailView.swift
//  MovieTCA
//
//  Created by 박현수 on 8/11/24.
//

import SwiftUI
import ComposableArchitecture
import MovieNetwork

public struct MovieDetailView: View {
    
    var store: StoreOf<MovieDetailFeature>
    
    public var body: some View {
        
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack {
                if viewStore.isLoading {
                    ProgressView()
                } else {
                    if let movie = viewStore.movie {
                        MovieDetailItemView(model: MovieDetailItemView.Model(movie: movie))
                    }
                }
            }
            .onAppear {
                viewStore.send(.start)
            }
        }
    }
}

public struct MovieDetailItemView: View {
    
    var model: Self.Model
    
    public struct Model {
        var movieTitle: String
        var moviePosterUrl: URL?
        
        init(movie: MovieDetailItem) {
            movieTitle = movie.title
            moviePosterUrl = movie.moviePosterUrl
        }
    }
    
    public var body: some View {
        return VStack(spacing: 30) {
            
            AsyncImage(url: model.moviePosterUrl) { image in
                image
                    .resizable()
                                    .aspectRatio(2/3, contentMode: .fill)
            } placeholder: {
                Color.gray
            }
//            .frame(width: geometry.size.width, height: geometry.size.width * 1.5)
            .cornerRadius(8)
            .clipped()
            .padding([.leading, .top, .bottom], 8)
            VStack(spacing: 8) {
                HStack(spacing: .zero) {
                    Spacer()
                    Text(model.movieTitle)
                        .lineLimit(2)
                        .font(.system(size: 15))
                    Spacer()
                }
            }
        }
    }
}
