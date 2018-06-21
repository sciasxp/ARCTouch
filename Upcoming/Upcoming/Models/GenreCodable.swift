//
//  Genre.swift
//  Upcoming
//
//  Created by Luciano Nunes on 04/06/18.
//  Copyright © 2018 ArcTouch. All rights reserved.
//

import Foundation

struct GenreCodable: Codable, Equatable {
    
    let id: Int32
    let name: String
}

extension GenreCodable: Hashable {
    
    var hashValue: Int {
        
        return id.hashValue ^ name.hashValue
    }
}
