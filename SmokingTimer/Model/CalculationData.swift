//
//  CalculationData.swift
//  SmokingTimer
//
//  Created by 神野成紀 on 2020/07/22.
//  Copyright © 2020 神野成紀. All rights reserved.
//

import Foundation

class CalculationData {
    private let levelCount: [Int]
    
    init(levelCount: [Int]) {
        self.levelCount = levelCount
    }
    
    func getCurrentLevel(totalSecond: Int) -> String {
        if totalSecond < 1200 {
            return StaticData.levels[0]
        } else if totalSecond >= 1200 {
            return StaticData.levels[1]
        } else if totalSecond >= 28800 {
            return StaticData.levels[2]
        } else if totalSecond >= 86400 {
            return StaticData.levels[3]
        } else if totalSecond >= 172800 {
            return StaticData.levels[4]
        } else if totalSecond >= 259200 {
            return StaticData.levels[5]
        } else if totalSecond >= 604800 {
            return StaticData.levels[6]
        } else if totalSecond >= 2592000 {
            return StaticData.levels[7]
        }
        return ""
    }
    
    func calculateNextLebel(date: Date, totalSecond: Int) -> String {
        let nowDate = Date()
        if totalSecond < 1200 {
            let toDate = Calendar.current.date(byAdding: .minute, value: 20, to: date)
            let timeValue = Calendar.current.dateComponents([.hour, .minute, .second],  from: nowDate, to: toDate!)
            return String(format: "%.2d: %.2d: %.2d", timeValue.hour!, timeValue.minute! ,timeValue.second!)
        } else if totalSecond >= 1200 {
            let toDate = Calendar.current.date(byAdding: .hour, value: 8, to: date)
            let timeValue = Calendar.current.dateComponents([.hour, .minute, .second],  from: nowDate, to: toDate!)
            return String(format: "%.2d: %.2d: %.2d", timeValue.hour!, timeValue.minute! ,timeValue.second!)
        } else if totalSecond >= 28800 {
            let toDate = Calendar.current.date(byAdding: .hour, value: 24, to: date)
            let timeValue = Calendar.current.dateComponents([.hour, .minute, .second],  from: nowDate, to: toDate!)
            return String(format: "%.2d: %.2d: %.2d", timeValue.hour!, timeValue.minute! ,timeValue.second!)
        } else if totalSecond >= 86400 {
            let toDate = Calendar.current.date(byAdding: .day, value: 2, to: date)
            let timeValue = Calendar.current.dateComponents([.day, .hour, .minute, .second],  from: nowDate, to: toDate!)
            return String(format: "%.2d\(StaticData.date) %.2d: %.2d: %.2d", timeValue.hour!, timeValue.minute! ,timeValue.second!)
        } else if totalSecond >= 172800 {
            let toDate = Calendar.current.date(byAdding: .day, value: 3, to: date)
            let timeValue = Calendar.current.dateComponents([.day, .hour, .minute, .second],  from: nowDate, to: toDate!)
            return String(format: "%.2d\(StaticData.date) %.2d: %.2d: %.2d", timeValue.hour!, timeValue.minute! ,timeValue.second!)
        } else if totalSecond >= 259200 {
            let toDate = Calendar.current.date(byAdding: .day, value: 7, to: date)
            let timeValue = Calendar.current.dateComponents([.day, .hour, .minute, .second],  from: nowDate, to: toDate!)
            return String(format: "%.2d\(StaticData.date) %.2d: %.2d: %.2d", timeValue.hour!, timeValue.minute! ,timeValue.second!)
        } else if totalSecond >= 604800 {
            let toDate = Calendar.current.date(byAdding: .day, value: 14, to: date)
            let timeValue = Calendar.current.dateComponents([.day, .hour, .minute, .second],  from: nowDate, to: toDate!)
            return String(format: "%.2d\(StaticData.date) %.2d: %.2d: %.2d", timeValue.hour!, timeValue.minute! ,timeValue.second!)
        } else if totalSecond >= 1209600 {
            return ""
        }
        return ""
    }
    
    func calculateLevelProgress(totalSecond: Int) -> Double {
        var parcentage: Double = 0
        var levelsProgress: Double = 0
        if totalSecond < 1200 {
            parcentage = Double(totalSecond) / Double(levelCount[0])
            levelsProgress = parcentage * 100
            return floor(levelsProgress * 100) / 100
        } else if totalSecond >= 1200 {
            parcentage = Double(totalSecond - 1200) / Double(levelCount[1])
            levelsProgress = parcentage * 100
            return floor(levelsProgress * 100) / 100
        } else if totalSecond >= 28800 {
            parcentage = Double(totalSecond - 28800) / Double(levelCount[2])
            levelsProgress = parcentage * 100
            return floor(levelsProgress * 100) / 100
        } else if totalSecond >= 86400 {
            parcentage = Double(totalSecond - 86400) / Double(levelCount[3])
            levelsProgress = parcentage * 100
            return floor(levelsProgress * 100) / 100
        } else if totalSecond >= 172800 {
            parcentage = Double(totalSecond - 172800) / Double(levelCount[4])
            levelsProgress = parcentage * 100
            return floor(levelsProgress * 100) / 100
        } else if totalSecond >= 259200 {
            parcentage = Double(totalSecond - 259200) / Double(levelCount[5])
            levelsProgress = parcentage * 100
            return floor(levelsProgress * 100) / 100
        } else if totalSecond >= 604800 {
            parcentage = Double(totalSecond - 604800) / Double(levelCount[6])
            levelsProgress = parcentage * 100
        } else if totalSecond >= 1209600 {
            return 100
        }
        return 0
    }
}
