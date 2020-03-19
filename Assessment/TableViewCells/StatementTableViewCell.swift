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
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setUpData(data: Statement){
        let month = Util.convertDateFormat(stringDate: data.stamtDate ?? "", givenFormat: "yyyy-MM-dd", expectedFormat: "MMMM")
        labelMonthName.text = month
        labelAccountInfo.text = ("Balance $\(data.balance ?? 0.0), In $\(data.credit ?? 0.0), Out $\(data.debit ?? 0.0)")
        
    }

}
