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
    private let view: HomeViewProtocol?
    private let calculationData: CalculationData?
    private var timer = Timer()
    private let user = UserDefaults.standard.string(forKey: "user")
    var boxPrice = UserDefaults.standard.integer(forKey: "boxPrice")
    var numberOfDay = UserDefaults.standard.integer(forKey: "numberOfDay")
    var numberOfBox = UserDefaults.standard.integer(forKey: "numberOfBox")
    private var finishDay = ""
    private var totalSecond = 0
    private var levelsProgress: Double = 0
    private let levelCount = [1200, 27600, 57600, 864000, 864000, 345600, 1209600]
    init(view: HomeViewProtocol) {
        self.view = view
        self.calculationData = CalculationData(levelCount: levelCount)
    }
    
    func getCurrentTime(start: Bool) {
        let date = Date()
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ja_JP")
        formatter.dateStyle = .medium
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
        let startDay = UserDefaults.standard.string(forKey: "startTime")
        let stopTime = view?.getStopTime()
        UserDefaults.standard.removeObject(forKey: "Date")
        db.collection("Users").document(user!).collection("History").addDocument(data: ["time": stopTime!, "order": Date().timeIntervalSince1970, "savedMoney": "\(savedMoney)\(StaticData.money)", "savedNumber": "\(savedNumber)\(StaticData.number)", "finishDay": finishDay, "startDay": startDay!]) { (err) in
            if let err = err {
                print(err)
            } else {
                print("succeed!")
            }
        }
    }
    
    @objc func dateCalculation() {
        guard let startDate = UserDefaults.standard.object(forKey: "Date") as! Date? else {return} 
        let now = Date()
        let dateComponents = Calendar.current.dateComponents([.day, .hour, .minute, .second], from: startDate, to: now)
        let totalSecondComp = Calendar.current.dateComponents([.second], from: startDate, to: now)
        totalSecond = totalSecondComp.second!
        savedMoney = calculateSavedMoney()
        savedNumber = calculateSavedNumber()
        view?.upDateTimer(timer: String(format: "\(dateComponents.day!)\(StaticData.date) %.2d: %.2d: %.2d", dateComponents.hour!, dateComponents.minute!, dateComponents.second!), money: "\(savedMoney)\(StaticData.money)", number: "\(savedNumber)\(StaticData.number)")
        view?.upDateLevels(level: (calculationData?.getCurrentLevel(totalSecond: totalSecond))!, next: (calculationData?.calculateNextLebel(date: startDate, totalSecond: totalSecond))!, progressValue: CGFloat((calculationData?.calculateLevelProgress(totalSecond: totalSecond))!))
    }
    
    func calculateSavedMoney() -> String {
        let unitPrice = boxPrice / numberOfBox
        let secondPerMoney = Double(unitPrice * numberOfDay) / 86400
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
