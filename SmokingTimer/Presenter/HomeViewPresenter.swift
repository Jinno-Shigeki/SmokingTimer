//
//  HomeViewPresenter.swift
//  SmokingTimer
//
//  Created by 神野成紀 on 2020/07/11.
//  Copyright © 2020 神野成紀. All rights reserved.
//

import Foundation
import Firebase

class HomeViewPresenter {
    private let db = Firestore.firestore()
    private var hour = 0
    private var minute = 0
    private var second = 0
    private var date = 0
    private var savedMoney: Double = 0
    private var view: HomeViewProtocol?
    private var timer = Timer()
    let user = UserDefaults.standard.string(forKey: "user")
    var secondPerMoney: Double = 0
    var boxPrice = 0
    var numberOfDay = 0
    
    init(view: HomeViewProtocol) {
        self.view = view
    }
    
    func getCurrentTime() -> String{
        let date = Date()
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ja_JP")
        formatter.dateStyle = .full
        formatter.timeStyle = .medium
        formatter.timeZone = TimeZone(identifier: "Asia/Tokyo")
        return formatter.string(from: date)
    }
    
    func startTimer(startTime: String){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        UserDefaults.standard.set(startTime, forKey: "startTime")
        print(second, minute, hour, date)
    }
    
    func stopTimer(){
        let finishDay = getCurrentTime()
        timer.invalidate()
        let startDay = UserDefaults.standard.string(forKey: "startTime")
        let stopTime = view?.getStopTime()
        db.collection("Users").document(user!).collection("History").addDocument(data: ["time": stopTime!, "savedMoney": "\(String(format: "%.2f", savedMoney))\(StaticData.money)", "finishDay": finishDay, "startDay": startDay!]) { (err) in
            if let err = err {
                print(err)
            } else {
                print("succeed!")
            }
        }
    }
    
    @objc func updateTimer(){
        second += 1
        savedMoney += secondPerMoney
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
        view?.upDateTimer(timer: "\(date)\(StaticData.date) \(hour)\(StaticData.hour) \(minute)\(StaticData.minute) \(second)\(StaticData.second)", money: savedMoney)
    }
    
    func getTobaccoData() {
        db.collection("Users").document(user!).getDocument { (doc, err) in
            if let doc = doc {
                self.boxPrice = doc.get("boxPrice") as! Int
                self.numberOfDay = doc.get("numberOfDay") as! Int
            } else if let err = err {
                print(err)
            }
        }
    }
    
    func moneyCalculation() {
        let unitPrice = boxPrice / 20
        print(unitPrice)
        secondPerMoney = Double(unitPrice * numberOfDay) / 86400
    }
}
