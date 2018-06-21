//
//  APIClient.swift
//  Upcoming
//
//  Created by Luciano Nunes on 04/06/18.
//  Copyright © 2018 ArcTouch. All rights reserved.
//

import Foundation

enum Either<T> {
    
    case success(T)
    case error(Error)
}

enum APIError: Error {
    
    case unknown, badResponse, jsonDecoder, imageDownload, imageConvert, noInternet
}

protocol APIClient {
    
    var session: URLSession { get }
    
    func get<T: Codable>(with request: URLRequest, decoder: JSONDecoder, completion: @escaping (Either<T>) -> Void)
}
