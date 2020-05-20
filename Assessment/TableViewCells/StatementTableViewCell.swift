//
//  StatementTableViewCell.swift
//  Assessment
//
//  Created by VishalP on 17/03/20.
//  Copyright © 2020 Vishal. All rights reserved.
//

import UIKit

class StatementTableViewCell: UITableViewCell {

    @IBOutlet weak var labelMonthName: UILabel!
    
    @IBOutlet weak var labelAccountInfo: UILabel!
    
    @IBOutlet weak var btnShare: UIButton!
    
    //MARK:- assign viewModel data to UI compenents
    var statementVM: StamentViewModel?{
        didSet{
            let month = Util.convertDateFormat(stringDate: statementVM?.stamtDate ?? "", givenFormat: "yyyy-MM-dd", expectedFormat: "MMMM")
            labelMonthName.text = month
            labelAccountInfo.text = getAccountInfoText(balance: statementVM?.balance ?? 0.0, credit: statementVM?.credit ?? 0.0, debit: statementVM?.debit ?? 0.0)
        }
    }
    private func getAccountInfoText(balance: Float, credit: Float, debit: Float) -> String{
        let acct = ("Balance $\(balance), In $\(credit), Out $\(debit)")
        return acct
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
//    func setUpData(data: Statement){
//        let month = Util.convertDateFormat(stringDate: data.stamtDate ?? "", givenFormat: "yyyy-MM-dd", expectedFormat: "MMMM")
//        labelMonthName.text = month
//        labelAccountInfo.text = ("Balance $\(data.balance ?? 0.0), In $\(data.credit ?? 0.0), Out $\(data.debit ?? 0.0)")
//    }
}
