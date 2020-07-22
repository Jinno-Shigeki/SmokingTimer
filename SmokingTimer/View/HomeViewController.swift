//
//  ViewController.swift
//  SmokingTimer
//
//  Created by 神野成紀 on 2020/07/04.
//  Copyright © 2020 神野成紀. All rights reserved.
//

import UIKit
import MBCircularProgressBar

protocol HomeViewProtocol {
    func upDateTimer(timer: String, money: String, number: String)
    func getStopTime() -> String
    func upDateLevels(level: String, next: String, progressValue: CGFloat)
}

final class HomeViewController: UIViewController {
    
    @IBOutlet weak private var timerLabel: UILabel!
    @IBOutlet weak private var moneyLabel: UILabel!
    @IBOutlet weak private var startButton: UIButton!
    @IBOutlet weak private var helpButton: UIButton!
    @IBOutlet weak private var numberLabel: UILabel!
    @IBOutlet weak var startDateLebel: UILabel!
    @IBOutlet weak var nextLevel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var progressBarView: MBCircularProgressBarView!
    
    var presenter: HomeViewPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = HomeViewPresenter(view: self)
        layoutUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        if UserDefaults.standard.object(forKey: "Date") != nil {
            presenter.startTimer()
            startButton.setTitle(StaticData.stop, for: UIControl.State.normal)
            startDateLebel.text = UserDefaults.standard.string(forKey: "startTime")
        } else {
        presenter.boxPrice = UserDefaults.standard.integer(forKey: "boxPrice")
        presenter.numberOfBox = UserDefaults.standard.integer(forKey: "numberOfBox")
        presenter.numberOfDay = UserDefaults.standard.integer(forKey: "numberOfDay")
        }
    }
    
    @IBAction func tapBearButton(_ sender: Any) {
        let storyboard: UIStoryboard = self.storyboard!
        let nextVC = storyboard.instantiateViewController(identifier: "BearVC") as! BearViewController
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func tapStartButton(_ sender: UIButton) {
        if startButton.titleLabel?.text == StaticData.start {
            presenter.getCurrentTime(start: true)
            presenter.startTimer()
            startButton.setTitle(StaticData.stop, for: UIControl.State.normal)
            startDateLebel.text = UserDefaults.standard.string(forKey: "startTime")
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
            self.nextLevel.text = StaticData.nextlevel
            self.progressBarView.value = 0
            self.levelLabel.text = "Level.0"
            self.startDateLebel.text = ""
        }
        let cancelAction = UIAlertAction(title: StaticData.cancel, style: UIAlertAction.Style.cancel) { (action) in
            
        }
        alert.addAction(defaultAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    func layoutUI() {
        startButton.layer.cornerRadius = startButton.frame.height / 2
        helpButton.layer.cornerRadius = startButton.frame.height / 2
        startButton.layer.borderWidth = 3
        startButton.layer.borderColor = UIColor(named: "customGreen")?.cgColor
        helpButton.layer.borderWidth = 3
        helpButton.layer.borderColor = UIColor(named: "customGreen")?.cgColor
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        tabBarController?.tabBar.backgroundImage = UIImage()
        tabBarController?.tabBar.shadowImage = UIImage()
    }
}
//MARK: - HomeViewProtocol
extension HomeViewController: HomeViewProtocol {
    func upDateLevels(level: String, next: String, progressValue: CGFloat) {
        levelLabel.text = level
        nextLevel.text = next
        progressBarView.value = progressValue
    }
    
    func upDateTimer(timer: String, money: String, number: String) {
        timerLabel.text = timer
        moneyLabel.text = money
        numberLabel.text = number
    }
    
    func getStopTime() -> String{
        return timerLabel.text!
    }
}

