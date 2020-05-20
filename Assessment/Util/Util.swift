//
//  Util.swift
//  Assessment
//
//  Created by VishalP on 18/03/20.
//  Copyright © 2020 Vishal. All rights reserved.
//

import Foundation

class Util: NSObject {
    
    static func convertDateFormat(stringDate: String, givenFormat: String, expectedFormat: String) -> String?
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = givenFormat
        let date = dateFormatter.date(from: stringDate)
        dateFormatter.dateFormat = expectedFormat
        if let dateNew = date {
            return  dateFormatter.string(from: dateNew)
        } else{
            return nil
        }
    }
    
    static func convertStringToDate(stringDate: String, givenFormat: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = givenFormat
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        return dateFormatter.date(from: stringDate)
    }
}
