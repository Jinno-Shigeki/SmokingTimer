//
//  ViewController.swift
//  SmokingTimer
//
//  Created by 神野成紀 on 2020/07/04.
//  Copyright © 2020 神野成紀. All rights reserved.
//

import UIKit
protocol HomeViewProtocol {
    func upDateTimer(timer: String, money: String, number: String)
    func getStopTime() -> String
}
final class HomeViewController: UIViewController {
    
    @IBOutlet weak private var timerLabel: UILabel!
    @IBOutlet weak private var moneyLabel: UILabel!
    @IBOutlet weak private var startButton: UIButton!
    @IBOutlet weak private var helpButton: UIButton!
    @IBOutlet weak private var numberLabel: UILabel!
    var presenter: HomeViewPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = HomeViewPresenter(view: self)
    }
    
    @IBAction func tapStartButton(_ sender: UIButton) {
        if startButton.titleLabel?.text == StaticData.start {
            presenter.getCurrentTime(start: true)
            presenter.startTimer()
            startButton.setTitle(StaticData.stop, for: UIControl.State.normal)
        } else {
            displayAlert()
        }
    }
    func displayAlert() {
        let alert = UIAlertController(title: StaticData.stop, message: StaticData.alert, preferredStyle: UIAlertController.Style.actionSheet)
        let defaultAction = UIAlertAction(title: StaticData.stopTimer, style: UIAlertAction.Style.default) { (action) in
            self.presenter.getCurrentTime(start: false)
            self.presenter.stopTimer()
            self.startButton.setTitle(StaticData.start, for: UIControl.State.normal)
            self.timerLabel.text = StaticData.defaultTime
            self.moneyLabel.text = StaticData.defaultMoney
            self.numberLabel.text = StaticData.defaultNumber
        }
        let cancelAction = UIAlertAction(title: StaticData.cancel, style: UIAlertAction.Style.cancel) { (action) in
            
        }
        alert.addAction(defaultAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
}
//MARK: - HomeViewProtocol
extension HomeViewController: HomeViewProtocol {
    func upDateTimer(timer: String, money: String, number: String) {
        timerLabel.text = timer
        moneyLabel.text = money
        numberLabel.text = number
    }
    
    func getStopTime() -> String{
        return timerLabel.text!
    }
}

