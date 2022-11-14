//
//  EditingTableView.swift
//  UserInfoTask
//
//  Created by Федор Донсков on 14.11.2022.
//

import UIKit

final class EditingTableView: UITableView {
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        setupHierarchy()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupHierarchy() {
        delegate = self
        dataSource = self
        
        register(TextViewTableViewCell.self)
        register(DatePickerTableViewCell.self)
        register(PickerViewTableViewCell.self)
    }
}

// MARK: - UITableViewDataSource

extension EditingTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Resources.NameFields.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let nameField = Resources.NameFields.allCases[indexPath.row].rawValue
        
        switch indexPath.row {
        case 0...2:
            guard let cell = self.dequeueReusableCell(TextViewTableViewCell.self) else {
                return UITableViewCell()
            }
            
            cell.nameTextViewDelegate = self
            
            if indexPath.row == 1 {
                cell.configure(name: nameField, scrollEnabled: false)
            } else {
                cell.configure(name: nameField, scrollEnabled: true)
            }
            return cell
            
        case 3:
            guard let cell = self.dequeueReusableCell(DatePickerTableViewCell.self) else {
                return UITableViewCell()
            }
            
            cell.configure(name: nameField)
            return cell
        case 4:
            guard let cell = self.dequeueReusableCell(PickerViewTableViewCell.self) else {
                return UITableViewCell()
            }
            
            cell.configure(name: nameField)
            return cell
        default:
            return UITableViewCell()
        }
    }
}

// MARK: - UITableViewDelegate

extension EditingTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        indexPath.row == 1 ? UITableView.automaticDimension : 44
    }
}

extension EditingTableView: NameTextViewProtocol {
    func changeSize() {
        beginUpdates()
        endUpdates()
    }
}



