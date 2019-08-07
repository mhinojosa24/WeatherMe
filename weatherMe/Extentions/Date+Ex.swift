//
//  Date+Ex.swift
//  weatherMe
//
//  Created by Student Loaner 3 on 8/5/19.
//  Copyright © 2019 Student Loaner 3. All rights reserved.
//
import  Foundation

extension NSDate {
    
    func getDate() -> String{
        let now = Date()
        
        let formatter = DateFormatter()
        
        formatter.timeZone = TimeZone.current
        
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        let dateString = formatter.string(from: now)
        
        return dateString
    }

}
