//
//  ViewController.swift
//  SmokingTimer
//
//  Created by 神野成紀 on 2020/07/14.
//  Copyright © 2020 神野成紀. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    @IBOutlet weak var boxPrice: UITextField!
    @IBOutlet weak var numberOfDay: UITextField!
    @IBOutlet weak var numberOfBox: UITextField!
    @IBOutlet weak var okButton: UIButton!
    
    let presenter = StartViewPresenter()
    var UserId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserId = presenter.createID()
        boxPrice.delegate = self
        numberOfDay.delegate = self
        numberOfBox.delegate = self
        self.boxPrice.keyboardType = .numberPad
        self.numberOfDay.keyboardType = .numberPad
        self.numberOfBox.keyboardType = .numberPad
        createReturnKey()
        okButton.isEnabled = false
        okButton.backgroundColor = .lightGray
    }
    
    @IBAction func tapOkButton(_ sender: UIButton) {
        if boxPrice.text != "" && numberOfDay.text != "" && numberOfBox.text != "" {
            UserDefaults.standard.set(UserId, forKey: "user")
            presenter.sendStartData(user: UserId, boxPrice: boxPrice.text!, numberOfDay: numberOfDay.text!, numberOfBox: numberOfBox.text!)
            performSegue(withIdentifier: "next", sender: sender)
        }
    }
}
//MARK: - UITextFieldDelegate
extension StartViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if boxPrice.text != "" && numberOfDay.text != "" && numberOfBox.text != "" {
            okButton.isEnabled = true
            okButton.backgroundColor = UIColor(named: "customGreen")
            okButton.setTitleColor(UIColor(named: "LightGreen"), for: .normal)
        }
    }
    
    func createReturnKey() {
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let returnKey = UIBarButtonItem(title: StaticData.returnKey, style: .done, target: self, action: #selector(tapReturnKey))
        returnKey.tintColor = UIColor(named: "LightGreen")
        toolBar.items = [space, returnKey]
        boxPrice.inputAccessoryView = toolBar
        numberOfDay.inputAccessoryView = toolBar
        numberOfBox.inputAccessoryView = toolBar
    }
    @objc func tapReturnKey() {
        boxPrice.endEditing(true)
        numberOfDay.endEditing(true)
        numberOfBox.endEditing(true)
    }
}

