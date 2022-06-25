//
//  ViewController.swift
//  LandmarksApp
//
//  Created by Максим Шмидт on 13.05.2022.
//

import UIKit

final class LandmarksListViewController: UIViewController {
    
    private let cells: [CellType] = [
        .switchCell,
        .defaultCell(.init(name: Names.sobor, isFavorite: true, image: Images.sobor, description: Description.sobor, cityLocationName: CityName.sobor, location: Location.sobor)),
        .defaultCell(.init(name: Names.coliseum, isFavorite: true, image: Images.coliseum, description: Description.coliseum, cityLocationName: CityName.coliseum, location: Location.coliseum)),
        .defaultCell(.init(name: Names.greenland, isFavorite: false, image: Images.greenland, description: Description.greenland, cityLocationName: CityName.greenland, location: Location.greenland)),
        .defaultCell(.init(name: Names.louvre, isFavorite: false, image: Images.louvre, description: Description.louvre, cityLocationName: CityName.louvre, location: Location.louvre)),
        .defaultCell(.init(name: Names.statue, isFavorite: true, image: Images.statue, description: Description.statue, cityLocationName: CityName.statue, location: Location.statue))
    ]
    private var favoriteCells: [CellType] = []
    private var isShowingFavoriteCells = false

    // MARK: - UI Properties
    
    private lazy var tableView = makeTableView()
    
    // MARK: - VC life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

// MARK: - TableViewDelegate & TableViewDataSource

extension LandmarksListViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        isShowingFavoriteCells ? favoriteCells.count : cells.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item: CellType

        item = isShowingFavoriteCells ? favoriteCells[indexPath.row] : cells[indexPath.row]

        switch item {
        case .switchCell:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: SwitchTableViewCell.identifier,
                for: indexPath
            ) as? SwitchTableViewCell else {
                return UITableViewCell()
            }
            cell.switchHandler = { [weak self] isOn in
                guard let self = self else { return }
                if isOn {
                    self.favoriteCells = self.filterFavoriteCells()
                    self.isShowingFavoriteCells = true
                    self.favoriteCells.insert(.switchCell, at: 0)
                } else {
                    self.isShowingFavoriteCells = false
                }
                tableView.reloadData()
            }
            cell.configure()
            return cell
            
        case .defaultCell (let landmark):
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: LandmarkTableViewCell.identifier,
                for: indexPath
            ) as? LandmarkTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(model: landmark)
            return cell
        }
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let destination: LandmarkDetailsViewController
        let item = cells[indexPath.row]

        switch item {
        case .defaultCell(let landmark):
            destination = LandmarkDetailsViewController(
                currentLocation: landmark.location,
                currentNameLandmark: landmark.name,
                currentImageLandmark: landmark.image ?? UIImage(),
                currentDescriptionLandmark: landmark.description,
                currentCityLocationName: landmark.cityLocationName,
                isFavorite: landmark.isFavorite
            )
        case .switchCell:
            return
        }
        navigationController?.pushViewController(destination, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = cells[indexPath.row]
        switch item {
        case .switchCell:
            return 50
        case .defaultCell(_):
            return 67
        }
    }

    private func filterFavoriteCells() -> [CellType] {
        var favoriteCells: [CellType] = []
        for cell in cells {
            if case let .defaultCell(data) = cell, data.isFavorite {
                favoriteCells.append(cell)
            }
        }
        return favoriteCells
    }
}

// MARK: - Setup UI

private extension LandmarksListViewController {
    func setupUI() {
        view.backgroundColor = .white
        setupNavigationBar()
        view.addSubview(tableView)
        makeConstraints()
    }

    func makeTableView() -> UITableView {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.tintColor = .darkText
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(LandmarkTableViewCell.self, forCellReuseIdentifier: LandmarkTableViewCell.identifier)
        tableView.register(SwitchTableViewCell.self, forCellReuseIdentifier: SwitchTableViewCell.identifier)
        return tableView
    }
    
    func setupNavigationBar() {
        title = "Landmarks"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func makeConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
