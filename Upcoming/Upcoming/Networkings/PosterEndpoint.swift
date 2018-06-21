//
//  PosterEndpoint.swift
//  Upcoming
//
//  Created by Luciano Nunes on 04/06/18.
//  Copyright © 2018 ArcTouch. All rights reserved.
//

import Foundation

enum Size: String {
    
    case w92, w154, w185, w342, w500, w780, original
}

enum ImageEndpoint: Endpoint {
    
    case poster(size: Size, path: String)
    
    var baseURL: String {
        
        return "https://image.tmdb.org"
    }
    
    var path: String {
        
        switch self {
        case .poster(let size, let path):
            return "/t/p/\(size.rawValue)\(path)"
        }
    }
    
    var urlParameters: [URLQueryItem] {
        
        return []
    }
}
