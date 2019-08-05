//
//  ViewController.swift
//  weatherMe
//
//  Created by Student Loaner 3 on 8/5/19.
//  Copyright © 2019 Student Loaner 3. All rights reserved.
//

import UIKit
import HPOpenWeather
import Foundation
import CoreLocation


class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var detail: UILabel!
    @IBOutlet weak var gratitudeLabel: UILabel!
    
    @IBOutlet weak var stackView: UIStackView!
    let locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the 
        checkLocationServices()
        
    }

    @IBAction func pressedCold(_ sender: Any) {
        self.gratitudeLabel.text = "Don't forget to put on a sweather"
    }
    
    @IBAction func pressedHot(_ sender: Any) {
        self.gratitudeLabel.text = "Stay hydrated my friend!"
    }
    @IBAction func pressedSad(_ sender: Any) {
        self.gratitudeLabel.text = "I hope the rest of your day goes well"
    }
    @IBAction func pressedhappy(_ sender: Any) {
        self.gratitudeLabel.text = "Im glad your day is going well"
    }
    @IBAction func pressedTired(_ sender: Any) {
        self.gratitudeLabel.text = "I hope you rest well"
    }


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
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last! as CLLocation
        print(location)
        let key = "2d9885e4e681b6e8a88f5a951e2d362f"
        
        let api = HPOpenWeather(apiKey: key)
        let cityRequest = LocationRequest(CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude))
        
        api.requestCurrentWeather(with: cityRequest) { (current, error) in
            guard let current = current, error == nil else { return }
            let temp = Int(floor((current.main.temperature * 1.8) + 32))
            let des = current.condition.description
            DispatchQueue.main.sync {
                self.temperature.text = "\(temp)˚"
                self.detail.text = "it's \(des)"
            }
            
        }
    }
}
