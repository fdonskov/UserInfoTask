//
//  DatePickerTableViewCell.swift
//  UserInfoTask
//
//  Created by Федор Донсков on 13.11.2022.
//

import UIKit

final class DatePickerTableViewCell: UITableViewCell {
    
    static var idDatePickerCell = "idDatePickerCell"
    
    private let nameLabel = UILabel()
    
    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Date()
        datePicker.subviews[0].subviews[0].subviews[0].alpha = 0
        return datePicker
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupHierarchy() {
        selectionStyle = .none
        nameLabel.font = Resources.Fonts.avenirNextRegular(with: 18)
        
        addView(nameLabel)
        contentView.addView(datePicker)
    }
    
    public func configure(name: String, date: Date) {
        nameLabel.text = name
        datePicker.date = date
    }
    
    public func getCellValue() -> String {
        
        if datePicker.date.getStringFromDate() == Date().getStringFromDate() {
            return ""
        } else {
            return datePicker.date.getStringFromDate()
        }
    }
}

// MARK: - Set Constraints

extension DatePickerTableViewCell {
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            nameLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.35),
            
            datePicker.centerYAnchor.constraint(equalTo: centerYAnchor),
            datePicker.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5)
        ])
    }
}

