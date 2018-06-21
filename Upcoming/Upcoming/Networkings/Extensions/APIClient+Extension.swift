//
//  APIClient+Extension.swift
//  Upcoming
//
//  Created by Luciano Nunes on 04/06/18.
//  Copyright © 2018 ArcTouch. All rights reserved.
//

import Foundation

extension APIClient {
    
    var session: URLSession {
        
        return URLSession.shared
    }
    
    func get<T: Codable>(with request: URLRequest, decoder: JSONDecoder, completion: @escaping (Either<T>) -> Void) {
        
        let task = session.dataTask(with: request) { (data, response, error) in
            
            guard error == nil else {
                
                completion(.error(error!))
                return
            }
            
            guard let response = response as? HTTPURLResponse, 200..<300 ~= response.statusCode else {
                
                completion(.error(APIError.badResponse))
                return
            }
            
            guard let value = try? decoder.decode(T.self, from: data!) else {
                
                completion(.error(APIError.jsonDecoder))
                return
            }
            
            DispatchQueue.main.async {
                
                completion(.success(value))
            }
        }
        task.resume()
    }
}
