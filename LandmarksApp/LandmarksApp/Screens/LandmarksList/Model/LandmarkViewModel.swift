//
//  LandmarkViewModel.swift
//  LandmarksApp
//
//  Created by Максим Шмидт on 13.05.2022.
//

import class UIKit.UIImage
import class CoreLocation.CLLocation

struct Landmark {
    let name: String
    let isFavorite: Bool
    let image: UIImage?
    let description: String
    let cityLocationName: String
    let location: CLLocation
}
