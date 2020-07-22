//
//  ResultViewController.swift
//  SmokingTimer
//
//  Created by 神野成紀 on 2020/07/10.
//  Copyright © 2020 神野成紀. All rights reserved.
//

import UIKit
protocol ResultViewProtocol {
    func reloadData()
}

class ResultViewController: UIViewController {
    
    @IBOutlet weak var resultList: UITableView!
    var presenter: ResultViewPresenter!
    var cellCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutUI()
        resultList.delegate = self
        resultList.dataSource = self
        presenter = ResultViewPresenter(view: self)
        resultList.register(UINib(nibName: "ResultCell", bundle: nil), forCellReuseIdentifier: "ResultCell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        presenter.getHistory(first: true)
    }
    
    func layoutUI() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        tabBarController?.tabBar.backgroundImage = UIImage()
        tabBarController?.tabBar.shadowImage = UIImage()
    }
}
//MARK: - UITableViewDelegate
extension ResultViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == presenter.historyData.count - 1 && presenter.cellCount >= 5 {
            presenter.getHistory(first: false)
        }
    }
}
//MARK: - UITableViewDataSource
extension ResultViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.historyData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath) as! ResultCell
        cell.startDay.text = presenter.historyData[indexPath.row].startDay
        cell.finishDay.text = presenter.historyData[indexPath.row].finishDay
        cell.recordTime.text = presenter.historyData[indexPath.row].timeRecord
        cell.savedMoney.text = presenter.historyData[indexPath.row].savedMoney
        cell.savedNumber.text = presenter.historyData[indexPath.row].savedNumber
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return StaticData.history
    }
}
//MARK: - ResultViewProtocol
extension ResultViewController: ResultViewProtocol{
    func reloadData() {
        resultList.reloadData()
    }
}
