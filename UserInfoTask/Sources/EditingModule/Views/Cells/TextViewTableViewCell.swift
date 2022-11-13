//
//  TextViewTableViewCell.swift
//  UserInfoTask
//
//  Created by Федор Донсков on 13.11.2022.
//

import UIKit

protocol NameTextViewProtocol: AnyObject {
    func changeSize()
}

final class TextViewTableViewCell: UITableViewCell {
    
    static var idTextViewCell = "idTextViewCell"
    
    weak var nameTextViewDelegate: NameTextViewProtocol?
    
    private let nameLabel = UILabel()
    private let nameTextView = NameTextView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupHierarchy()
        setupLayout()
        textViewDidChange(nameTextView)
        layoutIfNeeded()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupHierarchy() {
        selectionStyle = .none
        nameLabel.font = Resources.Fonts.avenirNextRegular(with: 18)
        
        addView(nameLabel)
        contentView.addView(nameTextView)
        
        nameTextView.delegate = self
    }
    
    public func configure(name: String, scrollEnabled: Bool) {
        nameLabel.text = name
        nameTextView.isScrollEnabled = scrollEnabled
    }
}

// MARK: - UITextViewDelegate

extension TextViewTableViewCell: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        contentView.heightAnchor.constraint(equalTo: nameTextView.heightAnchor, multiplier: 1).isActive = true
        
        nameTextViewDelegate?.changeSize()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .lightGray {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Введите данные"
            textView.textColor = .lightGray
        }
    }
}

// MARK: - Set Constraints

extension TextViewTableViewCell {
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            nameLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.35),
        
            nameTextView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            nameTextView.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 10),
            nameTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
}

