//
//  Mood.swift
//  weatherMe
//
//  Created by Student Loaner 3 on 8/5/19.
//  Copyright © 2019 Student Loaner 3. All rights reserved.
//

import Foundation
import RealmSwift

class Mood: Object {
    @objc dynamic var mood: String? = nil
    @objc dynamic var date: String? = nil
    @objc dynamic var img: String? = nil
    
    
}

struct MyMood {
    var imgMood: ImageType?
    var moodType: MoodType?
//    var date: String?
}

enum MoodType: String {
    case Sad = "sad"
    case Happy = "happy"
    case Hot = "hot"
    case Cold = "cold"
    case Tired = "Tired"
    
    var string: String {
        get {
            return self.rawValue as String
        }
    }
}

enum ImageType: String {
    case Sad = "☹️"
    case Happy = "☺️"
    case Hot = "🤒"
    case Cold = "🥶"
    case Tired = "😴"
    var string: String {
        get {
            return self.rawValue as String
        }
    }
}


extension Mood {
    func writetoRealm() {
        try! uiRealm.write {
            uiRealm.add(self)
        }
    }
}




