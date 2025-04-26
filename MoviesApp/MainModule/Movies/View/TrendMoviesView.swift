//
//  TrendMoviesView.swift
//  MoviesApp
//
//  Created by Alisher Sultanov on 26/4/25.
//

import UIKit

final class TrendMoviesView: UIView {
    
    // MARK: UI components
    
    lazy var trendMoviesTableView: UITableView = {
        let view = UITableView(frame: .zero, style: .grouped)
        view.backgroundColor = .systemBackground
        view.isScrollEnabled = true
//        view.separatorStyle = .none
//        view.isUserInteractionEnabled = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.hidesWhenStopped = true
        view.style = .large
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: Lifecycle
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .systemBackground
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Set up UI
    
    private func setUpUI() {
        addSubviews()
        setUpConstraints()
    }
    
    private func addSubviews() {
        addSubview(trendMoviesTableView)
        addSubview(activityIndicator)
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            trendMoviesTableView.topAnchor.constraint(equalTo: topAnchor),
            trendMoviesTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            trendMoviesTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            trendMoviesTableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            activityIndicator.heightAnchor.constraint(equalToConstant: 20),
            activityIndicator.widthAnchor.constraint(equalToConstant: 20),
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}
