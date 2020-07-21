//
//  CellCection.swift
//  SmokingTimer
//
//  Created by 神野成紀 on 2020/07/21.
//  Copyright © 2020 神野成紀. All rights reserved.
//

import Foundation

struct CellSection {
    var level: String
    var levelContent: String
    var expanded: Bool
    
    init(level: String, levelContent: String, expanded: Bool) {
        self.level = level
        self.levelContent = levelContent
        self.expanded = expanded
    }
}
