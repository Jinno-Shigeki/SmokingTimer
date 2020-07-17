//
//  ResultCell.swift
//  SmokingTimer
//
//  Created by 神野成紀 on 2020/07/16.
//  Copyright © 2020 神野成紀. All rights reserved.
//

import UIKit

class ResultCell: UITableViewCell {

    @IBOutlet weak var startDay: UILabel!
    @IBOutlet weak var finishDay: UILabel!
    @IBOutlet weak var recordTime: UILabel!
    @IBOutlet weak var savedMoney: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
