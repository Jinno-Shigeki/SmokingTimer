//
//  SystemHeader.swift
//  SmokingTimer
//
//  Created by 神野成紀 on 2020/07/21.
//  Copyright © 2020 神野成紀. All rights reserved.
//

import UIKit

protocol ExpandableHeaderViewDelegate {
    func toggleSection(header: ExpandableHeaderView, section: Int)
}
class ExpandableHeaderView: UITableViewHeaderFooterView {
    var delegate: ExpandableHeaderViewDelegate?
    var section: Int!
    let titleLabel = UILabel()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectHeader)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func selectHeader(gestureRecognizer: UITapGestureRecognizer) {
        let cell = gestureRecognizer.view as! ExpandableHeaderView
        delegate?.toggleSection(header: self, section: cell.section)
    }
    
    func customInit(delegate: ExpandableHeaderViewDelegate, section: Int, title: String) {
        self.delegate = delegate
        self.section = section
        titleLabel.text = title
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.backgroundColor = UIColor(named: "customBlack")
        titleLabel.frame = CGRect(x: self.contentView.frame.width / 20, y: self.contentView.frame.height / 6, width: self.contentView.frame.width / 2, height: self.contentView.frame.height / 1.5)
        titleLabel.font = UIFont.systemFont(ofSize: self.contentView.frame.height / 2)
        titleLabel.textColor = .white
        let imageView = UIImageView()
        imageView.frame = CGRect(x: self.contentView.frame.width - self.contentView.frame.width / 10, y: self.contentView.frame.height * (5 / 12), width: self.contentView.frame.height / 3, height: self.contentView.frame.height / 6)
        imageView.image = UIImage(systemName: "chevron.down")
        imageView.tintColor = .darkGray
        self.addSubview(titleLabel)
        self.addSubview(imageView)
    }
}
