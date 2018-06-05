//
//  Endpoint.swift
//  Upcoming
//
//  Created by Luciano Nunes on 04/06/18.
//  Copyright © 2018 ArcTouch. All rights reserved.
//

import Foundation

protocol Endpoint {
    
    var baseURL: String { get }
    var path: String { get }
    var urlParameters: [URLQueryItem] { get }
}
