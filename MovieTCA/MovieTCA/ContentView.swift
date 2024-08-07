//
//  ContentView.swift
//  MovieTCA
//
//  Created by 박현수 on 8/6/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var movieFetch = MovieFetch()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .onAppear(perform: {
            movieFetch.fetchMovie()
        })
    }
}

#Preview {
    ContentView()
}
