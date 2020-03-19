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
    
    static func sortAndGroupDateByYear(dateArray:[Statement]) -> [[Statement]] {
        if dateArray.isEmpty {
            return []
        }
        var resultArray = [[dateArray[0]]]
        
        let calendar = Calendar(identifier: .gregorian)
        for (prevDate, nextDate) in zip(dateArray, dateArray.dropFirst()) {
            let date1 = self.convertStringToDate(stringDate: prevDate.stamtDate ?? "", givenFormat: "yyyy-MM-dd")
            let date2 = self.convertStringToDate(stringDate: nextDate.stamtDate ?? "", givenFormat: "yyyy-MM-dd")
            if let dt1 = date1, let dt2 = date2{
            if !calendar.isDate(dt1, equalTo: dt2, toGranularity: .year) {
                resultArray.append([]) // Start new row
            }
            }
            resultArray[resultArray.count - 1].append(nextDate)
        }
        return resultArray
    }
}
