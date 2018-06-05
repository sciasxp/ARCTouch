//
//  Array+Extension.swift
//  Upcoming
//
//  Created by Luciano Nunes on 05/06/18.
//  Copyright © 2018 ArcTouch. All rights reserved.
//

extension Array where Element: Hashable {
    
    func removingDuplicates() -> [Element] {
    
        var addedDict = [Element: Bool]()
        
        return filter {
            
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }
    
    mutating func removeDuplicates() {
        
        self = self.removingDuplicates()
    }
}
