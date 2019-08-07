//
//  WeatherVC+Extention.swift
//  weatherMe
//
//  Created by Student Loaner 3 on 8/5/19.
//  Copyright © 2019 Student Loaner 3. All rights reserved.
//

import UIKit
import CoreLocation

extension WeatherViewController: CLLocationManagerDelegate {
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            checkLocationAuthorization()
        } else {
            showLocationDisablePopUp()
        }
    }
    
    //NOTE: checks the authorization status for user location
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        case .denied:
            // show alert instructing the how to turn on permissions
            showLocationDisablePopUp()
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        case .restricted:
            showLocationDisablePopUp()
            break
        case .authorizedAlways:
            break
        @unknown default:
            fatalError()
        }
    }
    
    //NOTE: alert view for bad requests when accessing user location
    func showLocationDisablePopUp() {
        let alert = UIAlertController(title: "Background Location Access Disabled", message: "In order to give you the best weather accuracy enable your location.", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let openAction = UIAlertAction(title: "Open Settings", style: .default) { (action) in
            
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        alert.addAction(cancel)
        alert.addAction(openAction)
        self.present(alert, animated: true, completion: nil)
    }
}
