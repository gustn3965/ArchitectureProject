//
//  ContentView.swift
//  MovieTCA
//
//  Created by 박현수 on 8/6/24.
//

import SwiftUI
import ComposableArchitecture

struct ContentView: View {

    var store: StoreOf<MovieListFeature>
    
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .onAppear(perform: {
//            movieFetch.fetchMovie()
        })
    }
}

//#Preview {
//    ContentView()
//}
