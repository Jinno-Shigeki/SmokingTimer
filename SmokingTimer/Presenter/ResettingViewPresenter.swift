//
//  ResettingViewPresenter.swift
//  SmokingTimer
//
//  Created by 神野成紀 on 2020/07/22.
//  Copyright © 2020 神野成紀. All rights reserved.
//

import Foundation

class ResettingViewPresenter {
    let view: ResettingViewProtocol!
    let user = UserDefaults.standard.string(forKey: "user")
    
    init(view: ResettingViewProtocol) {
        self.view = view
    }
    
    func resetStartData(boxPrice: String, numberOfDay: String, numberOfBox: String) {
        UserDefaults.standard.removeObject(forKey: "boxPrice")
        UserDefaults.standard.removeObject(forKey: "numberOfDay")
        UserDefaults.standard.removeObject(forKey: "numberOfBox")
        UserDefaults.standard.set(Int(boxPrice)!, forKey: "boxPrice")
        UserDefaults.standard.set(Int(numberOfDay)!, forKey: "numberOfDay")
        UserDefaults.standard.set(Int(numberOfBox)!, forKey: "numberOfBox")
    }
}
