//
//  MainViewController.swift
//  UserInfoTask
//
//  Created by Федор Донсков on 13.11.2022.
//

import UIKit

final class MainViewController: UIViewController {
    
    private let mainTableView = MainTableView()
    
    private var userModel = UserModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getUserModel()
        setupHierarchy()
        setupLayout()
        setValueArray()
    }
    
    private func setupHierarchy() {
        title = "Просмотр"
        view.backgroundColor = .white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Редактировать",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(editingTapped))
        
        view.addView(mainTableView)
    }
    
    @objc private func editingTapped() {
        let editingTableViewController = EditingViewController(userModel)
        navigationController?.pushViewController(editingTableViewController, animated: true)
    }
    
    private func getUserModel() {
        userModel = UserDefaultsHelper.getUserModel()
    }
    
    private func saveEditModel(_ model: UserModel) {
        UserDefaultsHelper.saveUserValue(Resources.NameFields.firstName.rawValue, model.firstName)
        UserDefaultsHelper.saveUserValue(Resources.NameFields.secondName.rawValue, model.secondName)
        UserDefaultsHelper.saveUserValue(Resources.NameFields.thirdName.rawValue, model.thirdName)
        UserDefaultsHelper.saveUserValue(Resources.NameFields.birthday.rawValue, model.birthday)
        UserDefaultsHelper.saveUserValue(Resources.NameFields.gender.rawValue, model.gender)
    }
    
    private func getValueArray() -> [String] {
        var valueArray = [String]()
        
        for key in Resources.NameFields.allCases {
            let value = UserDefaultsHelper.getUserValue(key.rawValue)
            valueArray.append(value)
        }
                
        return valueArray
    }
    
    private func setValueArray() {
        let valueArray = getValueArray()
        mainTableView.setValueArray(valueArray)
        mainTableView.reloadData()
    }

    public func changeUserModel(model: UserModel) {
        saveEditModel(model)
        
        userModel = model
        mainTableView.reloadData()
    }
}


// MARK: - Setup Layout

extension MainViewController {
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            mainTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            mainTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            mainTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            mainTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
}
