//
//  MainViewController.swift
//  UserInfoTask
//
//  Created by Федор Донсков on 13.11.2022.
//

import UIKit

final class MainViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupHierarchy()
        setupTableView()
    }
    
    private func setupHierarchy() {
        title = "Просмотр"
        view.backgroundColor = .white
    }
    
    private func setupTableView() {
        tableView.register(MainTableViewCell.self,
                           forCellReuseIdentifier: MainTableViewCell.idMainTableViewCell)
    }
}


// MARK: - UITableViewDataSource

extension MainViewController {
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

extension MainViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        indexPath.row == 1 ? UITableView.automaticDimension : 44
    }
}

