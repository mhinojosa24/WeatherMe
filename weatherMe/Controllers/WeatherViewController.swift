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
import RealmSwift


class WeatherViewController: UIViewController {
    
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var detail: UILabel!
    @IBOutlet weak var gratitudeLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    let locationManager = CLLocationManager()
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        checkLocationServices()
    }
    
    
    
    @IBAction func pressedCold(_ sender: Any) {
        self.gratitudeLabel.text = "Don't forget to put on a sweather"
        //TODO: add mood and time stamp
        
    }
    
    @IBAction func pressedHot(_ sender: Any) {
        self.gratitudeLabel.text = "Stay hydrated my friend!"
        let currrentMood = MyMood(imgMood: .Hot, moodType: .Hot)
        let now = Date()
        
        let formatter = DateFormatter()
        
        formatter.timeZone = TimeZone.current
        
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        let dateString = formatter.string(from: now)
        let moodToAdd = Mood()
        moodToAdd.img = currrentMood.imgMood?.string
        moodToAdd.mood = currrentMood.moodType?.string
        moodToAdd.date = dateString
        moodToAdd.writetoRealm()
        
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

    @IBAction func didPressedLogBTN(_ sender: Any) {
        if let logVC = storyboard?.instantiateViewController(withIdentifier: "logVC") as? LogViewController {
            
            navigationController?.pushViewController(logVC, animated: true)
        }
    }
    
    
    
    func getTimeStamp () -> String {
        let now = Date()
        
        let formatter = DateFormatter()
        
        formatter.timeZone = TimeZone.current
        
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        let dateString = formatter.string(from: now)
        return dateString
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


