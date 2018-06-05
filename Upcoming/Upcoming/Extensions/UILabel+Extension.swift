//
//  UILabel+Extension.swift
//  Upcoming
//
//  Created by Luciano Nunes on 05/06/18.
//  Copyright © 2018 ArcTouch. All rights reserved.
//

import UIKit

extension UILabel {
    
    enum Loading {
        
        static let message: String = NSLocalizedString("Loading...", comment: "Loading message")
        static let greetings: String = NSLocalizedString("Looking for a movie?", comment: "Greetings message while loading data")
    }
    
    enum App {
        
        static let title: String = NSLocalizedString("Upcoming", comment: "App title to be displayed at main navigation bar")
    }
    
    enum PalceHolders {
        
        static let searchMovies: String = NSLocalizedString("Search for a movie!", comment: "Message to instigate search")
    }
    
    enum ErrorMessages {
        
        static let title: String = NSLocalizedString("Error", comment: "Title for errors messages")
    }
}
