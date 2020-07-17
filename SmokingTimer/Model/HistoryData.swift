//
//  HistoryData.swift
//  SmokingTimer
//
//  Created by 神野成紀 on 2020/07/16.
//  Copyright © 2020 神野成紀. All rights reserved.
//

import Foundation
import Firebase

class HistoryData {
    let startDay: String
    let finishDay: String
    let savedMoney: String
    let timeRecord: String
    
    init(document: QueryDocumentSnapshot) {
        self.startDay = document.get("startDay") as! String
        self.finishDay = document.get("finishDay") as! String
        self.savedMoney = document.get("savedMoney") as! String
        self.timeRecord = document.get("time") as! String
    }
}
