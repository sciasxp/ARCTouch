//
//  MovieTableViewCell.swift
//  Upcoming
//
//  Created by Luciano Nunes on 05/06/18.
//  Copyright © 2018 ArcTouch. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    static let formatter: DateFormatter = {
        
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        
        return formatter
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setMovie(_ movie: UpcomingCodable) {
    
        if let posterPath = movie.posterPath, let url = PosterEndpoint.poster(size: .w500, posterPath: posterPath).request.url {
        
        try? self.posterImageView.image = UIImage(data: Data(contentsOf: url))
        }
        
        self.titleLabel.text = movie.title
        self.releaseDateLabel.text = MovieTableViewCell.formatter.string(from: movie.releaseDate)
    }

}
