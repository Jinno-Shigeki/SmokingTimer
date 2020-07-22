//
//  ResultViewPresenter.swift
//  SmokingTimer
//
//  Created by 神野成紀 on 2020/07/16.
//  Copyright © 2020 神野成紀. All rights reserved.
//

import Foundation
import Firebase

class ResultViewPresenter {
    let db = Firestore.firestore()
    let view: ResultViewProtocol!
    let user = UserDefaults.standard.string(forKey: "user")
    var historyData: [HistoryData] = []
    var order: Double = 0
    var cellCount = 0
    
    init(view: ResultViewProtocol) {
        self.view = view
    }
    
    func getHistory(first: Bool) {
        if first {
            refresh()
            db.collection("Users").document(user!).collection("History").order(by: "order", descending: true).limit(to: 5).getDocuments { (query, err) in
                if let query = query {
                    query.documents.forEach { (doc) in
                        self.historyData.append(HistoryData(document: doc))
                    }
                    self.cellCount = query.count
                } else if let err = err {
                    print(err)
                }
                if self.cellCount != 0 {
                self.order = self.historyData.last!.order
                self.view.reloadData()
                }
            }
        } else {
            db.collection("Users").document(user!).collection("History").order(by: "order", descending: true).start(after: [order]).limit(to: 5).getDocuments { (query, err) in
                if let query = query {
                    query.documents.forEach { (doc) in
                        self.historyData.append(HistoryData(document: doc))
                    }
                    self.cellCount = query.count
                } else if let err = err {
                    print(err)
                }
                self.order = self.historyData.last!.order
                self.view.reloadData()
            }
        }
    }
    
    func refresh() {
        historyData.removeAll()
    }
}

