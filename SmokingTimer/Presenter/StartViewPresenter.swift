//
//  StartViewPresenter.swift
//  SmokingTimer
//
//  Created by 神野成紀 on 2020/07/14.
//  Copyright © 2020 神野成紀. All rights reserved.
//

import Foundation
import Firebase

class StartViewPresenter {
    let db = Firestore.firestore()
    
    func sendStartData(user :String, boxPrice: String, numberOfDay: String) {
        db.collection("Users").document(user).setData(["user": user, "boxPrice": boxPrice, "numberOfDay": numberOfDay]) { (err) in
            if let err = err {
                print(err)
            } else {
                print("success!")
            }
        }
    }
    func createID() -> String {
        let string = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ123456789"
        var id = ""
        for _ in 0..<16 {
        let randomElement = string.randomElement()
            id += String(randomElement!)
        }
        print(id)
        return id
    }
}
