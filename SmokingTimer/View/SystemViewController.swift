//
//  DetailViewController.swift
//  SmokingTimer
//
//  Created by 神野成紀 on 2020/07/10.
//  Copyright © 2020 神野成紀. All rights reserved.
//

import UIKit
import ExpandableCell

protocol DetailViewProtocol {
    
}
class SystemViewController: UIViewController {
   
    @IBOutlet weak var systemList: ExpandableTableView!
    var presenter: LevelListViewPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = LevelListViewPresenter(view: self)
        systemList.expandableDelegate = self
        systemList.animation = .fade
        systemList.register(UINib(nibName: "LevelListCell", bundle: nil), forCellReuseIdentifier: "LevelListCell")
    }
}
//MARK: - ExpandableDelegate
extension SystemViewController: ExpandableDelegate {
    func expandableTableView(_ expandableTableView: ExpandableTableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.height / 18
    }
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, numberOfRowsInSection section: Int) -> Int {
        return SystemData.systemMenu[section].count - 1
    }
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ExpandableCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.text = SystemData.systemMenu[indexPath.section][indexPath.row + 1]
        return cell
    }
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, expandedCellsForRowAt indexPath: IndexPath) -> [UITableViewCell]? {
        if indexPath.section == 1 {
            let cell = systemList.dequeueReusableCell(withIdentifier: "LevelListCell", for: indexPath) as! LevelListCell
            cell.levelCondition.text = SystemData.levelConditions[indexPath.row]
            return [cell]
        }
        return nil
    }
    func expandableTableView(_ expandableTableView: ExpandableTableView, heightsForExpandedRowAt indexPath: IndexPath) -> [CGFloat]? {
        if indexPath.section == 1 {
            return [150]
        }
        return nil
    }
    
    func numberOfSections(in expandableTableView: ExpandableTableView) -> Int {
        return SystemData.systemMenu.count
    }
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, titleForHeaderInSection section: Int) -> String? {
        return SystemData.systemMenu[section][0]
    }
    func expandableTableView(_ expandableTableView: ExpandableTableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    func expandableTableView(_ expandableTableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}
//MARK: - DetailViewProtocol
extension SystemViewController: DetailViewProtocol {
    
}

