//
//  RootViewController.swift
//  Upcoming
//
//  Created by Luciano Nunes on 05/06/18.
//  Copyright © 2018 ArcTouch. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var greetingsLabel: UILabel!
    @IBOutlet weak var loadingLabel: UILabel!
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    // MARK: -
    private var genres: Set<GenreCodable> = []
    private var movies: [UpcomingCodable] = []
    private var filteredMovies: [UpcomingCodable] = [] {
        didSet {
            
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Buffers
    
    private var moviesBuffer: Set<UpcomingCodable> = []
    
    // MARK: -
    private let networkClient = TMDbClient()
    
    private var page: Int = 1
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Configure Title
        ConfigureTitle()
        
        // Setup the Search Controller
        SetupSearchController()
        
        // Setup TableView
        self.loadingLabel.text = UILabel.Loading.message
        self.greetingsLabel.text = UILabel.Loading.greetings
        
        // Load Data
        loadGenres()
        loadMovies()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Helper Methods
    
    fileprivate func loadGenres() {
        
        let language = NSLocale.current.identifier.replacingOccurrences(of: "_", with: "-")
        let endpoint = TMDbEndpoint.genre(apiKey: TMDbClient.apiKey, language: language)
        
        networkClient.fetchGenres(with: endpoint) { (either) in
            
            switch either {
                
            case .success(let genreList):
                self.genres = self.genres.union(genreList.genres)
                
            case .error(let error):
                self.showAlert(with: UILabel.ErrorMessages.title, and: error.localizedDescription)
            }
        }
    }
    
    fileprivate func loadMovies() {
        
        let language = NSLocale.current.identifier.replacingOccurrences(of: "_", with: "-")
        let region = NSLocale.current.regionCode ?? "US"
        let endpoint = TMDbEndpoint.upcoming(apiKey: TMDbClient.apiKey, language: language, region: region, page: page)
        
        networkClient.fetchUpcomings(with: endpoint) { (either) in
            
            switch either {
                
            case .success(let resultList):
                self.moviesBuffer = self.moviesBuffer.union(resultList.results)
                self.tableView.isHidden = true
                
                self.page += 1
                if self.page <= resultList.totalPages {
                    
                    self.loadMovies()
                
                } else {
                    
                    self.movies = Array(self.moviesBuffer)
                    self.movies = self.movies.filter({ (movie) -> Bool in
                        
                        return movie.releaseDate > Date()
                    })
                    self.movies.sort(by: { (movie1, movie2) -> Bool in
                        
                        return movie1.releaseDate < movie2.releaseDate
                    })
                    self.tableView.reloadData()
                    self.tableView.isHidden = false
                }
                
            case .error(let error):
                self.tableView.isHidden = false
                self.showAlert(with: UILabel.ErrorMessages.title, and: error.localizedDescription)
            }
        }
    }
    
    fileprivate func ConfigureTitle() {
        
        if #available(iOS 11.0, *) {
            
            self.navigationController?.navigationBar.prefersLargeTitles = true
        }
        self.title = UILabel.App.title
    }
    
    fileprivate func SetupSearchController() {
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = UILabel.PalceHolders.searchMovies
        
        if #available(iOS 11.0, *) {
            
            navigationItem.searchController = searchController
            
        } else {
            // Fallback on earlier versions
            navigationItem.titleView = searchController.searchBar
        }
        definesPresentationContext = true
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
        case UIStoryboardSegue.Segue.detail:
            
            let cell = sender as! UITableViewCell
            guard let indexPath = self.tableView.indexPath(for: cell) else {
                return
            }
            
            let movie: UpcomingCodable
            if isFiltering() {
                
                movie = self.filteredMovies[indexPath.row]
                
            } else {
                
                movie = self.movies[indexPath.row]
            }
            
            let detail = segue.destination as! DetailViewController
            detail.setMovie(movie, and: genres)
        default:
            return
        }
    }
}

// MARK: - UITableViewDataSource

extension RootViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isFiltering() {
            
            return filteredMovies.count
        }
        
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.Identifiers.movie,
                                                 for: indexPath) as! MovieTableViewCell
        
        // Getting content
        let movie: UpcomingCodable
        
        if isFiltering() {
            
            movie = filteredMovies[indexPath.row]
            
        } else {
            
            movie = movies[indexPath.row]
        }
        
        cell.setMovie(movie)
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension RootViewController: UITableViewDelegate {
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - Search Results Updating

extension RootViewController: UISearchResultsUpdating {
    
    // MARK: - UISearchResultsUpdating Delegate
    
    func updateSearchResults(for searchController: UISearchController) {
        
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    // MARK: - Private instance methods
    
    private func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    private func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        
        filteredMovies = movies.filter({( movie: UpcomingCodable) -> Bool in
            
            return movie.title.lowercased().contains(searchText.lowercased())
        })
    }
    
    func isFiltering() -> Bool {
        
        return searchController.isActive && !searchBarIsEmpty()
    }
}
