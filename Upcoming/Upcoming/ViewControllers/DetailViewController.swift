//
//  DetailViewController.swift
//  Upcoming
//
//  Created by Luciano Nunes on 05/06/18.
//  Copyright © 2018 ArcTouch. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    // MARK: - Properties
    
    @IBOutlet weak var overViewLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    static let formatter: DateFormatter = {
        
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        
        return formatter
    }()
    
    // MARK: -
    
    private var movie: UpcomingCodable? = nil
    private var genres: Set<GenreCodable>? = nil
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup UI elements
        guard let movie = self.movie else {
            return
        }
        
        if let posterPath = movie.posterPath,
            let url = PosterEndpoint.poster(size: .w500, posterPath: posterPath).request.url {
            
            try? self.imageView.image = UIImage(data: Data(contentsOf: url))
        }
        
        
        self.titleLabel.text = movie.title
        self.releaseDateLabel.text = DetailViewController.formatter.string(from: movie.releaseDate)
        self.overViewLabel.text = movie.overview
        self.genreLabel.text = getGenresNames()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Setters
    
    func setMovie(_ movie: UpcomingCodable, and genres: Set<GenreCodable>) {
        
        self.movie = movie
        self.genres = genres
    }
    
    // MARK - Helper Methods
    
    func getGenresNames() -> String {
        
        guard let genres = self.genres,
            let movie = self.movie else {
            
            return ""
        }
        
        var genresString = ""
        
        genres.forEach { (genre) in
            
            guard let genresIds = movie.genreIds else {
                
                return
            }
            
            if genresIds.contains(genre.id) {
                
                if genresString.count > 0 {
                
                    genresString.append(", \(genre.name)")
                    
                } else {
                    
                    genresString.append(genre.name)
                }
            }
        }
        return genresString
    }
}
