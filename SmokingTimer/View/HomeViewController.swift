//
//  ViewController.swift
//  SmokingTimer
//
//  Created by 神野成紀 on 2020/07/04.
//  Copyright © 2020 神野成紀. All rights reserved.
//

import UIKit
protocol HomeViewProtocol {
    func upDateTimer(timer: String)
}
final class HomeViewController: UIViewController {
    
    @IBOutlet weak private var timerLabel: UILabel!
    @IBOutlet weak private var moneyLabel: UILabel!
    @IBOutlet weak private var startButton: UIButton!
    @IBOutlet weak private var helpButton: UIButton!
    var presenter: HomeViewPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = HomeViewPresenter(view: self)
    }
    @IBAction func tapStartButton(_ sender: UIButton) {
        presenter.getStartTime()
        presenter.timer()
    }
}
//MARK: - HomeViewProtocol
extension HomeViewController: HomeViewProtocol {
    func upDateTimer(timer: String) {
        timerLabel.text = timer
    }
}

