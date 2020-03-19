//
//  StamentModel.swift
//  Assessment
//
//  Created by VishalP on 17/03/20.
//  Copyright © 2020 Vishal. All rights reserved.
//

import Foundation

struct AllStatement: Decodable{
    let status: Status
    let stmts: [Statement]

    private enum CodingKeys: String, CodingKey {
        case status = "status"
        case stmts = "stmts"
    }
}

struct Status: Decodable{
    let code: String?
    let description: String?

    private enum CodingKeys: String, CodingKey {
        case code = "code"
        case description = "description"
    }
}

struct Statement: Decodable {
    let balance: Float?
    let credit: Float?
    let debit : Float?
    let stmtId: String?
    let stamtDate: String?

    private enum CodingKeys: String, CodingKey {
        case balance = "balance"
        case credit = "credit"
        case debit = "debit"
        case stmtId = "stmtId"
        case stamtDate = "stamtDate"
    }
}
