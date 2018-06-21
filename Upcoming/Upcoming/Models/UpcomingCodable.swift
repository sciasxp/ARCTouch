//
//  UpcomingCodable.swift
//  Upcoming
//
//  Created by Luciano Nunes on 04/06/18.
//  Copyright © 2018 ArcTouch. All rights reserved.
//

import Foundation

struct UpcomingCodable: Codable, Equatable {
    
    let id: Int32
    let title: String
    let overview: String
    let releaseDate: Date
    var posterPath: String?
    var backdropPath: String?
    let genreIds: Set<Int32>?
}

extension UpcomingCodable: Hashable {
    
    var hashValue: Int {
        
        return id.hashValue ^
            title.hashValue ^
            overview.hashValue ^
            releaseDate.hashValue
    }
}
