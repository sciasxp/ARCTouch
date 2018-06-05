//
//  Endpoint+Extension.swift
//  Upcoming
//
//  Created by Luciano Nunes on 04/06/18.
//  Copyright © 2018 ArcTouch. All rights reserved.
//

import Foundation

extension Endpoint {
    
    var urlComponent: URLComponents {
        
        var urlComponent = URLComponents(string: baseURL)
        urlComponent?.path = path
        urlComponent?.queryItems = urlParameters
        
        return urlComponent!
    }
    
    var request: URLRequest {
        
        return URLRequest(url: urlComponent.url!)
    }
}
