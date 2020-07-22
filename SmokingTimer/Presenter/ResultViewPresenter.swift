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
    
    init(view: ResultViewProtocol) {
        self.view = view
    }
    
    func getHistory() {
        refresh()
        db.collection("Users").document(user!).collection("History").order(by: "order").getDocuments { (query, err) in
            if let query = query {
                query.documents.forEach { (doc) in
                    self.historyData.append(HistoryData(document: doc))
                }
            } else if let err = err {
                print(err)
            }
            self.view.reloadData()
        }
    }
    
    func refresh() {
        historyData.removeAll()
    }
}

