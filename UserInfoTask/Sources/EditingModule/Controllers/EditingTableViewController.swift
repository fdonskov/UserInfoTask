//
//  EditingTableViewController.swift
//  UserInfoTask
//
//  Created by Федор Донсков on 13.11.2022.
//

import UIKit

final class EditingTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupHierarchy()
        setupTableView()
    }
    
    private func setupHierarchy() {
        title = "Просмотр"
        view.backgroundColor = .red
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(editingTapped))
    }
    
    private func setupTableView() {
        tableView.register(MainTableViewCell.self,
                           forCellReuseIdentifier: MainTableViewCell.idMainTableViewCell)
    }
    
    @objc private func editingTapped() {
        print("tap")
    }
}


// MARK: - UITableViewDataSource

extension EditingTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Resources.NameFields.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.idMainTableViewCell,
                                                       for: indexPath) as? MainTableViewCell else {
            return UITableViewCell()
        }
        
        let nameFirld = Resources.NameFields.allCases[indexPath.row].rawValue
        cell.configure(name: nameFirld)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension EditingTableViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        indexPath.row == 1 ? UITableView.automaticDimension : 44
    }
}


