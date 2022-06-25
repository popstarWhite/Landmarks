//
//  LandmarkDetailsViewController.swift
//  LandmarksApp
//
//  Created by Максим Шмидт on 24.06.2022.
//

import UIKit
import MapKit

final class LandmarkDetailsViewController: UIViewController {
    
    var currentNameLandmark: String
    var currentImageLandmark: UIImage
    var currentDescriptionLandmark: String
    var currentCityLocationName: String
    var currentLocation: CLLocation
    var isFavorite: Bool
    
    // MARK: - UI Properties

    private lazy var mapView = makeMapView()
    private lazy var nameLandmark = makeNameLandmark()
    private lazy var descriptionLandmark = makeDescriptionLandmark()
    private lazy var cityLocationName = makeCityLocationName()
    private lazy var imageLandmark = makeImageLandmark()
    private lazy var starSymbol = makeStarSymbol()
    
    // MARK: - ViewController LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - Initialization
    
    init(
        currentLocation: CLLocation,
        currentNameLandmark: String,
        currentImageLandmark: UIImage,
        currentDescriptionLandmark: String,
        currentCityLocationName: String,
        isFavorite: Bool
    ) {
        self.currentLocation = currentLocation
        self.currentNameLandmark = currentNameLandmark
        self.currentImageLandmark = currentImageLandmark
        self.currentDescriptionLandmark = currentDescriptionLandmark
        self.currentCityLocationName = currentCityLocationName
        self.isFavorite = isFavorite
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup UI

private extension LandmarkDetailsViewController {
    func setupView() {
        view.backgroundColor = .white
        [
            mapView,
            nameLandmark,
            imageLandmark,
            descriptionLandmark,
            cityLocationName,
            starSymbol
        ].forEach(view.addSubview)
        makeConstraints()
        checkFavoritesLandmarks()
    }
    
    func checkFavoritesLandmarks() {
        if isFavorite == true {
            starSymbol.isHidden = false
        } else {
            starSymbol.isHidden = true
        }
    }
    
    func makeMapView() -> MKMapView {
        let view = MKMapView()
        view.centerLocation(currentLocation)
        view.isZoomEnabled = false
        view.isScrollEnabled = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    func makeNameLandmark() -> UILabel {
        let view = UILabel()
        view.text = currentNameLandmark
        view.textColor = .darkText
        view.font = UIFont(name: "Montserrat-Medium", size: 27)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    func makeDescriptionLandmark() -> UILabel {
        let view = UILabel()
        view.text = currentDescriptionLandmark
        view.textColor = .darkText
        view.numberOfLines = 0
        view.font = UIFont(name: "Montserrat-Light", size: 21)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    func makeCityLocationName() -> UILabel {
        let view = UILabel()
        view.text = currentCityLocationName
        view.textColor = .darkText
        view.font = UIFont(name: "Montserrat-Light", size: 21)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    func makeImageLandmark() -> UIImageView {
        let view = UIImageView()
        view.image = currentImageLandmark
        view.layer.cornerRadius = 90
        view.clipsToBounds = true
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
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.leftAnchor.constraint(equalTo: view.leftAnchor),
            mapView.rightAnchor.constraint(equalTo: view.rightAnchor),
            mapView.heightAnchor.constraint(equalToConstant: 460),
            
            imageLandmark.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageLandmark.topAnchor.constraint(equalTo: view.topAnchor, constant: 340),
            imageLandmark.heightAnchor.constraint(equalToConstant: 200),
            imageLandmark.widthAnchor.constraint(equalToConstant: 200),
            
            nameLandmark.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: 88),
            nameLandmark.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
            
            descriptionLandmark.topAnchor.constraint(equalTo: nameLandmark.bottomAnchor, constant: 7),
            descriptionLandmark.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
            descriptionLandmark.widthAnchor.constraint(equalToConstant: 180),
            
            cityLocationName.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            cityLocationName.topAnchor.constraint(equalTo: nameLandmark.bottomAnchor, constant: 7),
            
            starSymbol.leftAnchor.constraint(equalTo: nameLandmark.rightAnchor, constant: 8),
            starSymbol.centerYAnchor.constraint(equalTo: nameLandmark.centerYAnchor),
            starSymbol.widthAnchor.constraint(equalToConstant: 18),
            starSymbol.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
}

extension MKMapView {
    func centerLocation(_ location: CLLocation, regionRadius: CLLocationDistance = 1000) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        setRegion(coordinateRegion, animated: true)
    }
}
