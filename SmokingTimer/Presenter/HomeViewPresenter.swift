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
    private var savedMoney = ""
    private var savedNumber = ""
    private var view: HomeViewProtocol?
    private var timer = Timer()
    private let user = UserDefaults.standard.string(forKey: "user")
    private var boxPrice = UserDefaults.standard.integer(forKey: "boxPrice")
    private var numberOfDay = UserDefaults.standard.integer(forKey: "numberOfDay")
    private var numberOfBox = UserDefaults.standard.integer(forKey: "numberOfBox")
    private var finishDay = ""
    private var totalSecond = 0
    init(view: HomeViewProtocol) {
        self.view = view
    }
    
    func getCurrentTime(start: Bool) {
        let date = Date()
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ja_JP")
        formatter.dateStyle = .full
        formatter.timeStyle = .medium
        formatter.timeZone = TimeZone(identifier: "Asia/Tokyo")
        let dateString = formatter.string(from: date)
        if start == true {
            saveStartDate(date: date, startTime: dateString)
        } else {
            finishDay = dateString
        }
    }
    
    func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(dateCalculation), userInfo: nil, repeats: true)
    }
    
    func stopTimer(){
        timer.invalidate()
        UserDefaults.standard.removeObject(forKey: "Date")
        let startDay = UserDefaults.standard.string(forKey: "startTime")
        let stopTime = view?.getStopTime()
        db.collection("Users").document(user!).collection("History").addDocument(data: ["time": stopTime!, "savedMoney": "\(savedMoney)\(StaticData.money)", "savedNumber": savedNumber, "finishDay": finishDay, "startDay": startDay!]) { (err) in
            if let err = err {
                print(err)
            } else {
                print("succeed!")
            }
        }
    }
    
    @objc func dateCalculation() {
        let startDate = UserDefaults.standard.object(forKey: "Date") as! Date
        let now = Date()
        let dateComponents = Calendar.current.dateComponents([.day, .hour, .minute, .second], from: startDate, to: now)
        savedMoney = calculateSavedMoney(dateComponents: dateComponents)
        savedNumber = calculateSavedNumber()
        view!.upDateTimer(timer: "\(dateComponents.day!)\(StaticData.date) \( dateComponents.hour!)\(StaticData.hour) \( dateComponents.minute!)\(StaticData.minute) \(dateComponents.second!)\(StaticData.second)", money: "\(savedMoney)\(StaticData.money)", number: "\(savedNumber)\(StaticData.number)")
    }
    
    func calculateSavedMoney(dateComponents: DateComponents) -> String {
        let unitPrice = boxPrice / numberOfBox
        let secondPerMoney = Double(unitPrice * numberOfDay) / 86400
        let secondOfDays = dateComponents.day! * 86400
        let secondOfHours = dateComponents.hour! * 360
        let secondOfMinutes = dateComponents.minute! * 60
        totalSecond = secondOfDays + secondOfHours + secondOfMinutes + dateComponents.second!
        let currentMooney = Double(totalSecond) * secondPerMoney
        savedMoney = String(format: "%.2f", currentMooney)
        return savedMoney
    }
    
    func calculateSavedNumber() -> String {
        let secondPerNumber = 86400 / Double(numberOfDay)
        let currentNumber = Double(totalSecond) / secondPerNumber
        let savedNumber = String(Int(currentNumber))
        return savedNumber
    }
    
    func saveStartDate(date: Date, startTime: String) {
        if UserDefaults.standard.object(forKey: "Date") != nil {
            UserDefaults.standard.removeObject(forKey: "Date")
            UserDefaults.standard.removeObject(forKey: "startTime")
        }
            UserDefaults.standard.set(date, forKey: "Date")
            UserDefaults.standard.set(startTime, forKey: "startTime")
    }
}
