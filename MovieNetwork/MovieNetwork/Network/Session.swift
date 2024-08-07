//
//  Session.swift
//  MovieNetwork
//
//  Created by 박현수 on 8/8/24.
//

import Foundation
import Combine

public protocol SessionProtocol {
    func publisherForURL(for url: URL) -> AnyPublisher<(data: Data, response: URLResponse), URLError>
}

extension URLSession: SessionProtocol {
    
    public func publisherForURL(for url: URL) -> AnyPublisher<(data: Data, response: URLResponse), URLError> {
        return dataTaskPublisher(for: url)
            .eraseToAnyPublisher()
    }
}
