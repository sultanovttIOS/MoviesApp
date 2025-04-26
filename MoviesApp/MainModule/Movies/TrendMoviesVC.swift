//
//  ViewController.swift
//  MoviesApp
//
//  Created by Alisher Sultanov on 26/4/25.
//

import UIKit

final class TrendMoviesVC: UIViewController {
    
    private lazy var moviesView = TrendMoviesView()
    private let model: MoviesModelProtocol
    private var isAllMoviesLoaded = false
    private var isLoadingMovies = false
    
    // MARK: Lifecycle
    
    init(model: MoviesModelProtocol) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = moviesView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewConfigure()
        getTrendMovies(append: false)
        title = "Trending Movies"
    }
    
    private func tableViewConfigure() {
        moviesView.trendMoviesTableView.register(
            TrendMovieCell.self,
            forCellReuseIdentifier: TrendMovieCell.reuseID)
        moviesView.trendMoviesTableView.dataSource = self
        moviesView.trendMoviesTableView.delegate = self
        moviesView.trendMoviesTableView.rowHeight = UITableView.automaticDimension
        moviesView.trendMoviesTableView.estimatedRowHeight = 50
    }
    
    private func getTrendMovies(append: Bool) {
        guard !isLoadingMovies else { return }
        isLoadingMovies = true
        
        Task {
            defer {
                self.isLoadingMovies = false
            }
            
            do {
                let oldCount = model.movies.count
                try await model.fetchMovies(append: append)
                let newCount = model.movies.count
                
                if newCount == oldCount {
                    isAllMoviesLoaded = true
                }
                
                DispatchQueue.main.async {
                    self.moviesView.trendMoviesTableView.reloadData()
                    print("Movies count: \(self.model.movies.count)")
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

// MARK: UICollectionViewDataSource

extension TrendMoviesVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.movies.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCell(
                withIdentifier: TrendMovieCell.reuseID,
                for: indexPath) as! TrendMovieCell
            
            let movie = model.movies[indexPath.row]
            let number = indexPath.row + 1
            cell.configure(with: movie, number: number)
            return cell
        }
}

extension TrendMoviesVC: UITableViewDelegate {
    
    func tableView(
        _ tableView: UITableView,
        willDisplay cell: UITableViewCell,
        forRowAt indexPath: IndexPath) {
            
            if indexPath.row >= model.movies.count - 2,
               !isLoadingMovies,
               !isAllMoviesLoaded {
                getTrendMovies(append: true)
            }
        }
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath) {
            
            if indexPath.row < model.movies.count {
                
            }
        }
    
    func tableView(
        _ tableView: UITableView,
        heightForHeaderInSection section: Int) -> CGFloat {
        return .leastNormalMagnitude
    }
    
    func tableView(
        _ tableView: UITableView,
        viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
}
