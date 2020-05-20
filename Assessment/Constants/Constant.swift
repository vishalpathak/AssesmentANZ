//
//  File.swift
//  Assessment
//
//  Created by VishalP on 18/03/20.
//  Copyright © 2020 Vishal. All rights reserved.
//

import Foundation


let BaseFileName = "test"
let FileExtension = "json"

let BaseUrlPath: URL? = {
    if let path = Bundle.main.url(forResource: BaseFileName, withExtension: FileExtension){
        return path
    }else{
        return nil
    }
}()
struct CommonStrings {
    static let Title = "Statement history"
    static let CurrentStateMent = "Current Statement"
    static let ThisMonth = "This Month"
}
struct DateFormatStrings{
    static let FullYearHalfMonthDay = ""
    static let FullYear = ""
    static let FullMonthFullYear = ""
    static let FullYearFullMonthDay = ""
}
struct StamentText {
    static let PDFStatement = "Bank Statement (PDF)"
    static let CSVStatement = "Comma Seprated (CSV)"
    static let QIFStatement = "Quicken/Microsoft Money (QIF)"
    static let Dismiss = "Dismiss"
}

