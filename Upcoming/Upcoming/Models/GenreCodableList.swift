//
//  GenreCodableList.swift
//  Upcoming
//
//  Created by Luciano Nunes on 04/06/18.
//  Copyright © 2018 ArcTouch. All rights reserved.
//

import Foundation

struct GenreCodableList: Codable {
    
    let genres: Set<GenreCodable>
}
