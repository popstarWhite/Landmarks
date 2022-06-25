//
//  UISwitchTableViewCell.swift
//  LandmarksApp
//
//  Created by Максим Шмидт on 14.05.2022.
//

import UIKit

final class SwitchTableViewCell: UITableViewCell {
    
    private lazy var title = makeTitle()
    private lazy var favoriteSwitch = makeFavoriteSwitch()
    private var notFavoriteCell: [Landmark] = []
    var switchHandler: ((_ isOn: Bool) -> Void)?
    
    func configure() {
        setupCell()
        let action = UIAction { [weak self] _ in
            guard let self = self else { return }
            self.switchHandler?(self.favoriteSwitch.isOn)
        }
        favoriteSwitch.addAction(action, for: .valueChanged)
    }
    
    func findNotFavoritesCell(landmark: [Landmark]) {
        for item in landmark {
            if item.isFavorite == false {
                notFavoriteCell.append(item)
            }
        }
    }
}

private extension SwitchTableViewCell {
    func makeTitle() -> UILabel {
        let view = UILabel()
        view.text = "Favorites only"
        view.font = UIFont(name: "Montserrat-Medium", size: 24)
        view.textColor = .darkText
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    func makeFavoriteSwitch() -> UISwitch {
        let view = UISwitch()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }

    func makeConstraints() {
        NSLayoutConstraint.activate([
            favoriteSwitch.centerYAnchor.constraint(equalTo: centerYAnchor),
            favoriteSwitch.rightAnchor.constraint(equalTo: rightAnchor, constant: -12),

            title.centerYAnchor.constraint(equalTo: centerYAnchor),
            title.leftAnchor.constraint(equalTo: leftAnchor, constant: 12)
        ])
    }
    
    func setupCell() {
        contentView.addSubview(favoriteSwitch)
        contentView.addSubview(title)
        makeConstraints()
    }
}
