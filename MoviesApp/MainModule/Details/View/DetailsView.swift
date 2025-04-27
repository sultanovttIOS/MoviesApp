//
//  DetailsView.swift
//  MoviesApp
//
//  Created by Alisher Sultanov on 27/4/25.
//

import UIKit

final class DetailsView: UIView {
    
    // MARK: UI components
    
    lazy var detailsTableView: UITableView = {
        let view = UITableView(frame: .zero, style: .grouped)
        view.backgroundColor = .systemBackground
        view.isScrollEnabled = true
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
        addSubview(detailsTableView)
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            detailsTableView.topAnchor.constraint(equalTo: topAnchor),
            detailsTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            detailsTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            detailsTableView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
