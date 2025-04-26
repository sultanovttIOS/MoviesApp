//
//  TrendMovieCell.swift
//  MoviesApp
//
//  Created by Alisher Sultanov on 26/4/25.
//

import UIKit

final class TrendMovieCell: UITableViewCell {
    
    //MARK: Properties
    
    static let reuseID = String(describing: TrendMovieCell.self)

    //MARK: UI components
    
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 18, weight: .regular)
        view.textColor = .systemTeal
        view.textAlignment = .left
        view.lineBreakMode = .byWordWrapping
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let numberLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 18, weight: .regular)
        view.textColor = .secondaryLabel
        view.textAlignment = .left
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let dateLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 13, weight: .regular)
        view.textColor = .secondaryLabel
        view.textAlignment = .left
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        dateLabel.text = nil
    }
    
    private func setUpUI() {
        addSubviews()
        setUpConstraints()
    }
    
    func configure(with model: Movie, number: Int) {
        numberLabel.text = "\(number)"
        titleLabel.text = model.title
        dateLabel.text = "\(model.year)-year"
     }
    
    //MARK: addSubviews
    
    private func addSubviews() {
        contentView.addSubview(numberLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(dateLabel)
    }
    
    //MARK: Set Up Constraints
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            numberLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            numberLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            numberLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            
            titleLabel.topAnchor.constraint(equalTo: numberLabel.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: numberLabel.trailingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -100),
            titleLabel.bottomAnchor.constraint(equalTo: numberLabel.bottomAnchor),
            
            dateLabel.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        ])
    }
}

