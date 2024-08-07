//
//  MovieFetch.swift
//  MovieTCA
//
//  Created by 박현수 on 8/6/24.
//

import Foundation
import MovieNetwork
import Combine

class MovieFetch: ObservableObject {
    
    var movieRepo = MovieListRepository(network: DefaultNetwork(session: URLSession.shared))
    var cancellable = Set<AnyCancellable>()
    
    func fetchMovie() {
        movieRepo.getMovieList()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Successfully received data.")
                case .failure(let error):
                    print("Error received: \(error)")
                }
            }, receiveValue: { movies in
                print("Received movies: \(movies)")
                // 여기서 movies 데이터를 사용해 원하는 작업을 수행합니다.
            })
            .store(in: &cancellable)
    }
}
