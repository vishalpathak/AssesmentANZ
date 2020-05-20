//
//  ViewModel.swift
//  Assessment
//
//  Created by VishalP on 19/03/20.
//  Copyright © 2020 Vishal. All rights reserved.
//

import Foundation

struct StamentViewModel {
    let balance: Float?
    let credit: Float?
    let debit : Float?
    let stmtId: String?
    let stamtDate: String?
    
    //DI
    init(statement: Statement) {
        self.balance = statement.balance
        self.credit = statement.credit
        self.debit = statement.debit
        self.stmtId = statement.stmtId
        self.stamtDate = statement.stamtDate
    }
}

protocol DataReceivedDelegate: class {
    func didReceivedDataFromUrl(statementViewModel:[[StamentViewModel]]?, error: Error?)
}

final class StatementsViewModel{
    weak var dataReceivedDelegate: DataReceivedDelegate?
    
    func getDataFromUrl(urlPath: URL?){
        NetworkService.sharedService.dataFromURLPath(urlPath: urlPath) {(data: AllStatement?, error: Error?) in
            if let err = error{
                self.dataReceivedDelegate?.didReceivedDataFromUrl(statementViewModel: nil, error: err)
                return
            }
            if let res = data{
                var arrayStaments = [Statement]()
                arrayStaments = res.stmts
                arrayStaments.sort { (lhs: Statement, rhs: Statement) -> Bool in
                    let datet1 = Util.convertStringToDate(stringDate: lhs.stamtDate ?? "", givenFormat: "yyyy-MM-dd")
                    let datet2 = Util.convertStringToDate(stringDate: rhs.stamtDate ?? "", givenFormat: "yyyy-MM-dd")
                    if let dt1 = datet1, let dt2 = datet2{
                        return dt1 > dt2
                    }
                    return false
                }
                let arrayViewModel = res.stmts.map({ (rowObj: Statement) -> StamentViewModel in
                    return StamentViewModel(statement: rowObj)
                })
                var arr = self.sortAndGroupDateByYear(dateArray: arrayViewModel)
                let obj = arr[0][0]
                let arrN = [obj]
                arr.insert(arrN, at: 0)
                self.dataReceivedDelegate?.didReceivedDataFromUrl(statementViewModel: arr, error: nil)
            }else{
                //Handle spcial cases and errors
            }
        }
    }
    
    func sortAndGroupDateByYear(dateArray:[StamentViewModel]) -> [[StamentViewModel]] {
        if dateArray.isEmpty {
            return []
        }
        var resultArray = [[dateArray[0]]]
        
        let calendar = Calendar(identifier: .gregorian)
        for (prevDate, nextDate) in zip(dateArray, dateArray.dropFirst()) {
            let date1 = Util.convertStringToDate(stringDate: prevDate.stamtDate ?? "", givenFormat: "yyyy-MM-dd")
            let date2 = Util.convertStringToDate(stringDate: nextDate.stamtDate ?? "", givenFormat: "yyyy-MM-dd")
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
