//
//  DutchSummaryTableCell.swift
//  tosshomeworkSample
//
//  Created by Eido Goya on 2021/10/02.
//  Copyright © 2021 Viva Republica. All rights reserved.
//

import UIKit

class DutchSummaryTableCell: UITableViewCell {
    
    static let reuseIdentifier = "DutchSummaryTableCell"
    
    var dateLabel: UILabel!
    var amountLabel: UILabel!
    var messageLabel: UILabel!
    var messageContainer: UIView!
    
    var height: CGFloat = 100
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DutchSummaryTableCell {
    private func setupLayout() {
        
        selectionStyle = .none
        
        dateLabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        amountLabel = {
            let label = UILabel()
            label.font = .systemFont(ofSize: 10)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        messageLabel = {
            let label = UILabel()
            label.numberOfLines = 0
            label.lineBreakMode = .byWordWrapping
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        messageContainer = {
            let view = UIView()
            view.backgroundColor = .gray.withAlphaComponent(0.3)
            view.layer.cornerRadius = 10.0
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        
        contentView.addSubview(dateLabel)
        contentView.addSubview(amountLabel)
        contentView.addSubview(messageContainer)
        
        messageContainer.addSubview(messageLabel)
        
        let constraints = [
            dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            dateLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20)
        ] + [
            amountLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10),
            amountLabel.leftAnchor.constraint(equalTo: dateLabel.leftAnchor)
        ] + [
            messageContainer.topAnchor.constraint(equalTo: amountLabel.bottomAnchor, constant: 20),
            messageContainer.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            messageContainer.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),
            messageContainer.heightAnchor.constraint(equalToConstant: 60)
        ] + [
            messageLabel.centerYAnchor.constraint(equalTo: messageContainer.centerYAnchor),
            messageLabel.leftAnchor.constraint(equalTo: messageContainer.leftAnchor, constant: 10),
            messageLabel.rightAnchor.constraint(equalTo: messageContainer.rightAnchor, constant: -10)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
