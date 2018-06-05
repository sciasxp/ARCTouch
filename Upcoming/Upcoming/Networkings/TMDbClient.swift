//
//  TMDbClient.swift
//  Upcoming
//
//  Created by Luciano Nunes on 04/06/18.
//  Copyright © 2018 ArcTouch. All rights reserved.
//

import Foundation

class TMDbClient: APIClient {
    
    static let apiKey = "1f54bd990f1cdfb230adb312546d765d."
    
    private lazy var decoder: JSONDecoder = {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .formatted(formatter)
        return decoder
    }()
    
    func fetchUpcomings<T: Codable>(with endpoint: TMDbEndpoint, completion: @escaping (Either<T>) -> Void) {
        
        let request = endpoint.request
        get(with: request, decoder: decoder, completion: completion)
    }
    
    func fetchGenres<T: Codable>(with endpoint: TMDbEndpoint, completion: @escaping (Either<T>) -> Void) {
        
        let request = endpoint.request
        get(with: request, decoder: decoder, completion: completion)
    }
}
