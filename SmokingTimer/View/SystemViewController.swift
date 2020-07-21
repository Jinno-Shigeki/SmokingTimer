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
class SystemViewController: UIViewController {
    
    @IBOutlet weak var systemList: UITableView!
    var presenter: LevelListViewPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = LevelListViewPresenter(view: self)
        systemList.delegate = self
        systemList.dataSource = self
        layoutUI()
    }
    
    func layoutUI() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        tabBarController?.tabBar.backgroundImage = UIImage()
        tabBarController?.tabBar.shadowImage = UIImage()
    }
}
//MARK: - ExpandableDelegate
extension SystemViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK: - Section Header
extension SystemViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SystemCell", for: indexPath)
        if indexPath.section != 0 {
            cell.textLabel?.text = presenter.section[indexPath.section - SystemData.systemMenu.count].levelContent
            cell.textLabel?.numberOfLines = 20
            return cell
        } else {
            cell.textLabel?.text = SystemData.systemMenu[0]
            cell.textLabel?.font = UIFont.systemFont(ofSize: cell.frame.height / 2)
            let imageView = UIImageView()
            imageView.frame = CGRect(x: cell.frame.width - cell.contentView.frame.width / 10, y: cell.frame.height / 3, width: cell.frame.height / 4, height: cell.frame.height / 3)
            imageView.image = UIImage(systemName: "chevron.right")
            imageView.tintColor = .darkGray
            cell.addSubview(imageView)
            return cell
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.section.count + SystemData.systemMenu.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return tableView.frame.height / 16
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section != 0 {
            if (presenter.section[indexPath.section - 1].expanded) {
                return tableView.frame.height / 5
            } else {
                return 0
            }
        } else {
            return tableView.frame.height / 16
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section != 0 {
            let header = ExpandableHeaderView()
            header.customInit(delegate: self, section: section, title: presenter.section[section - SystemData.systemMenu.count].level)
            return header
        } else {
            return nil
        }
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section != 0 {
            return 1
        } else {
            return tableView.frame.height / 16
        }
    }
}
//MARK: - ExpandableHeaderViewDelegate
extension SystemViewController: ExpandableHeaderViewDelegate{
    func toggleSection(header: ExpandableHeaderView, section: Int) {
        if section != 0 {
            presenter.section[section - SystemData.systemMenu.count].expanded = !presenter.section[section - SystemData.systemMenu.count].expanded
            systemList.beginUpdates()
            systemList.reloadRows(at: [IndexPath(row: 0, section: section)], with: .automatic)
            systemList.endUpdates()
        }
    }
}
//MARK: - DetailViewProtocol
extension SystemViewController: DetailViewProtocol {
    
}

