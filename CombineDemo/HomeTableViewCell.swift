//
//  HomeTableViewCell.swift
//  CombineDemo
//
//  Created by luckyBoy on 2/26/23.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    lazy var titleLabel = UILabel.init()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        titleLabel.textColor = .black
        titleLabel.font = .systemFont(ofSize: 16)
        titleLabel.frame = contentView.bounds
        contentView.addSubview(titleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
