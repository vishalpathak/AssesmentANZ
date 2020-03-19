//
//  TopTableViewCell.swift
//  Assessment
//
//  Created by VishalP on 19/03/20.
//  Copyright © 2020 Vishal. All rights reserved.
//

import UIKit

class TopTableViewCell: UITableViewCell {

    
    @IBOutlet weak var labelCurrentMonth: UILabel!
    
    @IBOutlet weak var labelCurrentSatement: UILabel!
    
    @IBOutlet weak var lableBalance: UILabel!
    
    @IBOutlet weak var btnShareCurrent: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setCurrentData(data: Statement){
        let month = Util.convertDateFormat(stringDate: data.stamtDate ?? "", givenFormat: "yyyy-MM-dd", expectedFormat: "MMMM")
        if let name = month{
            labelCurrentMonth.text = "1 \(name) - Present"
        }else{
            labelCurrentMonth.text = "No month"
        }
        labelCurrentSatement.text = CommonStrings.CurrentStateMent
        lableBalance.text = ("$\(data.balance ?? 0.0)")
    }

}
