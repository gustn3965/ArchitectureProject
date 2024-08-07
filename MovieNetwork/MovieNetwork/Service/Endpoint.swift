//
//  Endpoint.swift
//  MovieNetwork
//
//  Created by 박현수 on 8/6/24.
//

import Foundation

public protocol Endpoint {
    
    var url: URL? { get }
    
    var path: String { get }
    
    var baseUrl: String { get }
    
    var httpMethod: String { get }
}

public enum MovieEndpoint: Endpoint {
    
    case movieList
    
    public var url: URL? {
        return URL(string: path)
    }
    public var path: String {
        switch self {
        case .movieList:
            return baseUrl + "/searchDailyBoxOfficeList?key=54b9821695ed46aeb98df09fb70f4243&targetDt=20240803"
        }
    }
    
    public var baseUrl: String {
        return "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice"
    }
    
    public var httpMethod: String {
        switch self {
        case .movieList:
            return "GET"
        }
    }
}
