//
//  DetailVC.swift
//  MoviesApp
//
//  Created by Alisher Sultanov on 26/4/25.
//

import UIKit

final class DetailVC: UIViewController {
    
    // MARK: Properties
    
    private let model: DetailsModelProtocol
    private let movieID: String
    private let detailsView = DetailsView()
    
    // MARK: Lifecycle
    
    init(model: DetailsModelProtocol, movieID: String) {
        self.model = model
        self.movieID = movieID
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = detailsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMovieByID()
        detailsTableViewConfigure()
        navigationController?.navigationBar.tintColor = .black
    }
    
    private func detailsTableViewConfigure() {
        detailsView.detailsTableView.dataSource = self
        detailsView.detailsTableView.delegate = self
        detailsView.detailsTableView.tableFooterView = UIView()
    }
    
    // MARK: Get Movie
    
    private func getMovieByID() {
        Task {
            do {
                try await model.getMovieByID(movieID: movieID)
                await MainActor.run {
                    detailsView.detailsTableView.reloadData()
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

// MARK: UITableViewDataSource

extension DetailVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 8
    }
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
            return 1
        }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
            cell.textLabel?.numberOfLines = 0
            cell.detailTextLabel?.numberOfLines = 0
            cell.selectionStyle = .none
            cell.textLabel?.font = UIFont.systemFont(ofSize: 17)
            cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 14)
            cell.detailTextLabel?.textColor = .secondaryLabel
            cell.textLabel?.textColor = .label
            
            switch indexPath.section {
            case 0:
                cell.textLabel?.text = model.movie?.title
                cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 22)
                cell.detailTextLabel?.text = "⭐️ \(model.movie?.imdbRating ?? "0")"
            case 1:
                cell.textLabel?.text = model.movie?.tagline ?? "*"
                cell.textLabel?.font = UIFont.italicSystemFont(ofSize: 18)
            case 2:
                cell.textLabel?.text = model.movie?.description ?? "*"
            case 3:
                cell.textLabel?.text = model.movie?.genres?.joined(separator: ", ") ?? "*"
            case 4:
                cell.textLabel?.text = model.movie?.directors?.joined(separator: ", ") ?? "*"
            case 5:
                cell.textLabel?.text = model.movie?.stars?.joined(separator: ", ") ?? "*"
            case 6:
                cell.textLabel?.text = "▶️ Watch Trailer"
                cell.textLabel?.textColor = .systemBlue
                cell.textLabel?.textAlignment = .center
                cell.accessoryType = .disclosureIndicator
            case 7:
                cell.textLabel?.text = """
                Year: \(model.movie?.year ?? "****")
                Release date: \(formattedDate(from: model.movie?.releaseDate ?? "*"))
                Runtime: \(model.movie?.runtime ?? 0) minutes
                Countries: \(model.movie?.countries?.joined(separator: ", ") ?? "*")
                Languages: \(model.movie?.language?.joined(separator: ", ") ?? "*")
                """
            default:
                break
            }
            return cell
            
        }
    
    private func formattedDate(from dateString: String?) -> String {
        guard let dateString = dateString else { return "-" }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        if let date = formatter.date(from: dateString) {
            formatter.dateStyle = .long
            return formatter.string(from: date)
        }
        return dateString
    }
}

// MARK: UITableViewDelegate

extension DetailVC: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        titleForHeaderInSection section: Int
    ) -> String? {
        
        switch section {
        case 0: return "Title"
        case 1: return "Tagline"
        case 2: return "Description"
        case 3: return "Genres"
        case 4: return "Directors"
        case 5: return "Stars"
        case 6: return "Trailer"
        case 7: return "Info"
        default: return nil
        }
    }
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        if indexPath.section == 6 {
            if let key = model.movie?.youtubeTrailerKey {
                if let url = URL(string: "https://www.youtube.com/watch?v=\(key)") {
                    UIApplication.shared.open(url)
                }
            }
        }
    }
    
    func tableView(
        _ tableView: UITableView,
        heightForHeaderInSection section: Int) -> CGFloat {
            return 30
        }
    
    func tableView(
        _ tableView: UITableView,
        viewForHeaderInSection section: Int) -> UIView? {
            let headerView = UIView()
            let label = UILabel()
            label.text = tableView.dataSource?.tableView?(tableView, titleForHeaderInSection: section)
            label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
            label.textColor = .secondaryLabel
            label.translatesAutoresizingMaskIntoConstraints = false
            headerView.addSubview(label)
            
            NSLayoutConstraint.activate([
                label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
                label.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
                label.topAnchor.constraint(equalTo: headerView.topAnchor),
                label.bottomAnchor.constraint(equalTo: headerView.bottomAnchor)
            ])
            
            return headerView
        }
}
