//
//  Endpoint.swift
//  MovieNetwork
//
//  Created by 박현수 on 8/6/24.
//

import Foundation

public protocol Endpoint {
    
    var request: URLRequest? { get }
    
    var url: URL? { get }
    
    var path: String { get }
    
    var baseUrl: String { get }
    
    var httpMethod: String { get }
    
    var header: [String: String] { get }
}

public enum MovieEndpoint: Endpoint {
    
    case movieList
    
    case movieDetail(String)
    
    public var url: URL? {
        return URL(string: path)
    }
    
    public var request: URLRequest? {
        guard let url = url else { return nil }
        
        var request = URLRequest(url: url)
        header.forEach {
            request.setValue($0.value, forHTTPHeaderField: $0.key)
        }
        return request
    }
    
    public var path: String {
        switch self {
        case .movieList:
            let now = Date.now
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyyMMdd"
            var dateString: String = "20240803"
            if let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: now) {
                dateString = formatter.string(from: yesterday)
            }
            return baseUrl + "/searchDailyBoxOfficeList?key=54b9821695ed46aeb98df09fb70f4243&targetDt=\(dateString)"
        case .movieDetail(let query):
            return baseUrl + "/movie?query=\(query)"
        }
    }
    
    public var baseUrl: String {
        switch self {
        case .movieList:
            return "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice"
        case .movieDetail:
            return "https://api.themoviedb.org/3/search"
        }
    }
    
    public var header: [String: String] {
        switch self {
        case .movieList:
            return [:]
        case .movieDetail:
            return ["Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlYjY3ODg1MGQ3MGM1NGI0ZjBjMzYyOWQxZDQ1Mjg5OCIsIm5iZiI6MTcyMjg2OTg0OC4xMDYzNDQsInN1YiI6IjVjYzZiYTQ3MGUwYTI2MzNkMGVlYTJhZiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.mY2JsmZ8j_tGtO7df2XbTSCzTafVybcBhDkudUBstAk"]
        }
    }
    
    public var httpMethod: String {
        switch self {
        case .movieList:
            return "GET"
        case .movieDetail:
            return "GET"
        }
    }
}
