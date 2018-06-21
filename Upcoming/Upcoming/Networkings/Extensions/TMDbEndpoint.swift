//
//  TMDbEndpoint.swift
//  Upcoming
//
//  Created by Luciano Nunes on 04/06/18.
//  Copyright © 2018 ArcTouch. All rights reserved.
//

import Foundation

enum TMDbEndpoint: Endpoint {
    
    case upcoming(apiKey: String, language: String, region: String, page: Int)
    case genre(apiKey: String, language: String)
    
    var baseURL: String {
        
        return "https://api.themoviedb.org"
    }
    
    var path: String {
        
        switch self {
        case .upcoming:
            return "/3/movie/upcoming"
        case .genre:
            return "/3/genre/movie/list"
        }
    }
    
    var urlParameters: [URLQueryItem] {
        
        switch self {
        case .upcoming(let apiKey, let language, let region, let page):
            return [
                URLQueryItem(name: "api_key", value: apiKey),
                URLQueryItem(name: "language", value: language),
                URLQueryItem(name: "region", value: region),
                URLQueryItem(name: "page", value: String(page))
            ]
        case .genre(let apiKey, let language):
            return [
                URLQueryItem(name: "api_key", value: apiKey),
                URLQueryItem(name: "language", value: language)
            ]
        }
    }
}
