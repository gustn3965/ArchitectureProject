//
//  NumberFactClient.swift
//  TCATutorial
//
//  Created by 박현수 on 8/24/24.
//

import Foundation
import ComposableArchitecture

struct NumberFactClient {
    var fetch: (Int) async throws -> String
}

extension NumberFactClient: DependencyKey {
    static var liveValue: NumberFactClient {
        Self { number in
            let (data, _) = try await URLSession.shared.data(from: URL(string:  "http://numbersapi.com/\(number)")!)
            
            return String(data: data, encoding: .utf8)!
        }
    }
}

extension DependencyValues {
    
    var numberFact: NumberFactClient {
        get { self[NumberFactClient.self] }
        set { self[NumberFactClient.self] = newValue }
    }
}
