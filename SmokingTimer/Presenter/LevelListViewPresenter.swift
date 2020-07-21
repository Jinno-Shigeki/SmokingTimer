//
//  DetailViewPresenter.swift
//  SmokingTimer
//
//  Created by 神野成紀 on 2020/07/18.
//  Copyright © 2020 神野成紀. All rights reserved.
//

import Foundation

class LevelListViewPresenter {
    let view: DetailViewProtocol!
    var section = [CellSection(level: SystemData.level[0], levelContent: SystemData.levelConditions[0], expanded: false), CellSection(level: SystemData.level[1], levelContent: SystemData.levelConditions[1], expanded: false), CellSection(level: SystemData.level[2], levelContent: SystemData.levelConditions[2], expanded: false), CellSection(level: SystemData.level[3], levelContent: SystemData.levelConditions[3], expanded: false), CellSection(level: SystemData.level[4], levelContent: SystemData.levelConditions[4], expanded: false), CellSection(level: SystemData.level[5], levelContent: SystemData.levelConditions[5], expanded: false), CellSection(level: SystemData.level[6], levelContent: SystemData.levelConditions[6], expanded: false)]
    init(view: DetailViewProtocol) {
        self.view = view
    }
    
}
