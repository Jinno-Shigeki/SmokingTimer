//
//  ResettingViewController.swift
//  SmokingTimer
//
//  Created by 神野成紀 on 2020/07/22.
//  Copyright © 2020 神野成紀. All rights reserved.
//

import UIKit
protocol ResettingViewProtocol {
    
}
class ResettingViewController: UIViewController {

    @IBOutlet weak var boxOfPrice: UITextField!
    @IBOutlet weak var numberOfBox: UITextField!
    @IBOutlet weak var numberOfDay: UITextField!
    @IBOutlet weak var okButton: UIButton!
    var presenter: ResettingViewPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = ResettingViewPresenter(view: self)
        boxOfPrice.delegate = self
        numberOfBox.delegate = self
        numberOfDay.delegate = self
        createReturnKey()
        self.boxOfPrice.keyboardType = .numberPad
        self.numberOfDay.keyboardType = .numberPad
        self.numberOfBox.keyboardType = .numberPad
        okButton.isEnabled = false
    }
    @IBAction func okButtonTap(_ sender: UIButton) {
        presenter.resetStartData(boxPrice: boxOfPrice.text!, numberOfDay: numberOfDay.text!, numberOfBox: numberOfBox.text!)
        boxOfPrice.text = ""
        numberOfDay.text = ""
        numberOfBox.text = ""
        okButton.backgroundColor = .darkGray
        okButton.setTitleColor(.white, for: .normal)
        okButton.isEnabled = false
    }
}
//MARK: -
extension ResettingViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if boxOfPrice.text != "" && numberOfDay.text != "" && numberOfBox.text != "" {
            okButton.isEnabled = true
            okButton.backgroundColor = UIColor(named: "customGreen")
            okButton.setTitleColor(UIColor(named: "LightGreen"), for: .normal)
        } else {
            okButton.backgroundColor = .darkGray
            okButton.setTitleColor(.white, for: .normal)
            okButton.isEnabled = false
        }
    }
    func createReturnKey() {
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let returnKey = UIBarButtonItem(title: StaticData.returnKey, style: .done, target: self, action: #selector(tapReturnKey))
        returnKey.tintColor = UIColor(named: "LightGreen")
        toolBar.items = [space, returnKey]
        boxOfPrice.inputAccessoryView = toolBar
        numberOfDay.inputAccessoryView = toolBar
        numberOfBox.inputAccessoryView = toolBar
    }
    @objc func tapReturnKey() {
        boxOfPrice.endEditing(true)
        numberOfDay.endEditing(true)
        numberOfBox.endEditing(true)
    }
}
//MARK: -
extension ResettingViewController: ResettingViewProtocol {
    
}

