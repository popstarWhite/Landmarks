//
//  LandmarkTableViewCell.swift
//  LandmarksApp
//
//  Created by Максим Шмидт on 16.05.2022.
//

import UIKit

final class LandmarkTableViewCell: UITableViewCell {
    
    private lazy var landmarkImageView = makeImageView()
    private lazy var landmarkTitleView = makeLabel()
    private lazy var starSymbol = makeStarSymbol()

    func configure(model: Landmark) {
        landmarkImageView.image = model.image
        landmarkTitleView.text = model.name
        checkOnFavorite(model: model)
        setupView()
        makeConstraints()
    }
    
    func checkOnFavorite(model: Landmark) {
        if model.isFavorite == false {
            starSymbol.isHidden = true
        } else {
            starSymbol.isHidden = false
        }
    }
}
    
private extension LandmarkTableViewCell {
    func setupView() {
        [
            landmarkImageView,
            landmarkTitleView,
            starSymbol,
        ].forEach(contentView.addSubview)
    }
    
    func makeImageView() -> UIImageView {
        let view = UIImageView()
        view.layer.cornerRadius = 29
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    func makeLabel() -> UILabel {
        let view = UILabel()
        view.font = UIFont(name: "Montserrat-Light", size: 21)
        view.textColor = .black
        view.numberOfLines = 0
        view.adjustsFontSizeToFitWidth = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    func makeStarSymbol() -> UIImageView {
        let view = UIImageView()
        view.image = UIImage(named: "StarSymbol")
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    func makeConstraints() {
        NSLayoutConstraint.activate([
            landmarkImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            landmarkImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            landmarkImageView.heightAnchor.constraint(equalToConstant: 58),
            landmarkImageView.widthAnchor.constraint(equalToConstant: 58),
            
            landmarkTitleView.leftAnchor.constraint(equalTo: landmarkImageView.rightAnchor, constant: 10),
            landmarkTitleView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            starSymbol.leftAnchor.constraint(equalTo: landmarkTitleView.rightAnchor, constant: 8),
            starSymbol.centerYAnchor.constraint(equalTo: centerYAnchor),
            starSymbol.heightAnchor.constraint(equalToConstant: 18),
            starSymbol.widthAnchor.constraint(equalToConstant: 18)
        ])
    }
}

extension UITableViewCell {
    static var identifier: String {
        String(describing: self)
    }
}
