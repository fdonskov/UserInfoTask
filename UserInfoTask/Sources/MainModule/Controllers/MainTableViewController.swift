//
//  MainViewController.swift
//  UserInfoTask
//
//  Created by Федор Донсков on 13.11.2022.
//

import UIKit

final class MainTableViewController: UITableViewController {
    
    private var userModel = UserModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getUserModel()
        setupHierarchy()
        setupTableView()
        print(userModel)
    }
    
    private func setupHierarchy() {
        title = "Просмотр"
        view.backgroundColor = .white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Редактировать",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(editingTapped))
    }
    
    private func setupTableView() {
        tableView.register(MainTableViewCell.self)
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

    public func changeUserModel(model: UserModel) {
        saveEditModel(model)
        
        userModel = model
        tableView.reloadData()
    }
}


// MARK: - UITableViewDataSource

extension MainTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Resources.NameFields.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(MainTableViewCell.self) else {
            return UITableViewCell()
        }
        
        let nameFirld = Resources.NameFields.allCases[indexPath.row].rawValue
        let value = UserDefaultsHelper.getUserValue(Resources.NameFields.allCases[indexPath.row].rawValue)
        cell.configure(name: nameFirld, value: value)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension MainTableViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        indexPath.row == 1 ? UITableView.automaticDimension : 44
    }
}
