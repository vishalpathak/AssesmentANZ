//
//  ViewModel.swift
//  Assessment
//
//  Created by VishalP on 19/03/20.
//  Copyright © 2020 Vishal. All rights reserved.
//

import Foundation

struct StamentViewModel {
    let year: String
    let accountInfo: String
    
    init(statement: Statement) {
        self.year = statement.stamtDate ?? ""
        self.accountInfo = "Bal:\(statement.balance ?? 0.0), In:\(statement.credit ?? 0.0), Out:\(statement.debit ?? 0.0)"
    }
}
