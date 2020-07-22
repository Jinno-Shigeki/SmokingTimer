//
//  LevelListCell.swift
//  SmokingTimer
//
//  Created by 神野成紀 on 2020/07/22.
//  Copyright © 2020 神野成紀. All rights reserved.
//

import UIKit

class LevelListCell: UITableViewCell {

    @IBOutlet weak var levelContent: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
