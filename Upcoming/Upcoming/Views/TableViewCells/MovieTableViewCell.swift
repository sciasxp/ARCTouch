//
//  MovieTableViewCell.swift
//  Upcoming
//
//  Created by Luciano Nunes on 05/06/18.
//  Copyright © 2018 ArcTouch. All rights reserved.
//

import UIKit
import Kingfisher

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var loadingActivity: UIActivityIndicatorView!
    
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
        
        // Reset content
        self.imageView?.image = #imageLiteral(resourceName: "MoviePlaceholder")
        self.titleLabel.text = ""
        self.releaseDateLabel.text = ""
        self.loadingActivity.startAnimating()
        
        // Get Image
        if let posterPath = movie.posterPath,
            let url = ImageEndpoint.poster(size: .w154, path: posterPath).request.url {
            
            self.imageView?.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "MoviePlaceholder")) { (image, error, cacheType, url) in
                
                self.loadingActivity.stopAnimating()
            }
            
        } else {
            
            self.loadingActivity.stopAnimating()
        }
        
        // Set other contents
        self.titleLabel.text = movie.title
        self.releaseDateLabel.text = MovieTableViewCell.formatter.string(from: movie.releaseDate)
    }
}
