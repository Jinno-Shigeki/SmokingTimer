//
//  DetailViewController.swift
//  SmokingTimer
//
//  Created by 神野成紀 on 2020/07/10.
//  Copyright © 2020 神野成紀. All rights reserved.
//

import UIKit
protocol DetailViewProtocol {
    
}
class LevelListViewController: UIViewController {
    @IBOutlet weak private var levelList: UITableView!
    var presenter: LevelListViewPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = LevelListViewPresenter(view: self)
        levelList.delegate = self
        levelList.dataSource = self
        levelList.register(UINib(nibName: "LevelListCell", bundle: nil), forCellReuseIdentifier: "cell")
    }
}
//MARK: - UITableViewDelegate
extension LevelListViewController: UITableViewDelegate {
    
}
//MARK: - UITableViewDataSource
extension LevelListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LevelListCell
        return cell
    }
}

//MARK: - DetailViewProtocol
extension LevelListViewController: DetailViewProtocol {
    
}

