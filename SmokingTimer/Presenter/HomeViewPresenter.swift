//
//  HomeViewPresenter.swift
//  SmokingTimer
//
//  Created by 神野成紀 on 2020/07/11.
//  Copyright © 2020 神野成紀. All rights reserved.
//

import Foundation

class HomeViewPresenter {
    var hour = 0
    var minute = 0
    var second = 0
    var date = 0
    var view: HomeViewProtocol?
    
    init(view: HomeViewProtocol) {
        self.view = view
    }
    
    func getStartTime() {
        let date = Date()
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ja_JP")
        formatter.dateStyle = .full
        formatter.timeStyle = .medium
        formatter.timeZone = TimeZone(identifier: "Asia/Tokyo")
        print(formatter.string(from: date))
    }
    
    func timer(){
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
         print(second, minute, hour, date)
    }
    
    @objc func updateTimer(){
        second += 1
        if second > 59 {
            minute += 1
            second = 0
        }
        if minute > 59 {
            hour += 1
            minute = 0
        }
        if hour > 23 {
            date += 1
            hour = 0
        }
        view?.upDateTimer(timer: "\(date)日 \(hour)時間 \(minute)分 \(second)秒")
    }
}
