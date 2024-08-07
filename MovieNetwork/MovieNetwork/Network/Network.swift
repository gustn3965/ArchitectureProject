//
//  Network.swift
//  MovieNetwork
//
//  Created by 박현수 on 8/6/24.
//

import Foundation
import Combine

public protocol NetworkProtocol {
    func request<T: Decodable>(endpoint: Endpoint) -> AnyPublisher<T, MError>
}

public enum MError: Error {
    case badUrl
    case badNetwork
    case badDecoding
    case unexpectedError
}


public final class DefaultNetwork: NetworkProtocol {
    private let session: SessionProtocol
    private let decoder = JSONDecoder()
    
    public init (session: SessionProtocol) {
        self.session = session
    }
    
    public func request<T>(endpoint: any Endpoint) -> AnyPublisher<T, MError> where T : Decodable {
        guard let url = endpoint.url else {
            return Fail(error: MError.badUrl).eraseToAnyPublisher()
        }
        
        return session.publisherForURL(for: url)
            .map({ data, response in
                if let jsonString = String(data: data, encoding: .utf8) {
                    print(jsonString)
                }
                return data
            })
            .decode(type: T.self, decoder: decoder)
            .mapError { error -> MError in
                switch error {
                case is Swift.DecodingError:
                    return .badDecoding
                default:
                    return .badNetwork
                }
            }
            .eraseToAnyPublisher()
    }
}
