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
        db.collection("Users").document(user!).collection("History").getDocuments { (query, err) in
            if let query = query {
                query.documents.forEach { (doc) in
                    self.historyData.append(HistoryData(document: doc))
                }
                print(self.historyData[0].savedMoney)
            } else if let err = err {
                print(err)
            }
            self.view.reloadData()
        }
    }
}

