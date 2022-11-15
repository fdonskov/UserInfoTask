//
//  EditingViewController.swift
//  UserInfoTask
//
//  Created by Федор Донсков on 13.11.2022.
//

import UIKit

final class EditingViewController: UIViewController {
    
    private let userPhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let editingTableView = EditingTableView()
    
    private var userModel = UserModel()
    
    override func viewWillLayoutSubviews() {
        userPhotoImageView.layer.cornerRadius = userPhotoImageView.frame.width / 2
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupHierarchy()
        setupLayout()
        addTaps()
    }
    
    init(_ userModel: UserModel) {
        self.userModel = userModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupHierarchy() {
        title = "Редактирование"
        view.backgroundColor = .white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(saveTapped))
        
        let backBarButtonItem = UIBarButtonItem.createCustomButton(vc: self, selector: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = backBarButtonItem
        view.addView(userPhotoImageView)
        editingTableView.setUserModel(userModel)
        view.addView(editingTableView)
    }
    
    @objc private func saveTapped() {
        
        let editUserModel = editingTableView.getUserModel()
        
        if authFields(model: editUserModel) {
            presentSimpleAlert(title: "Выполнено", message: "Все обязаельные поля заполнены")
        } else {
            presentSimpleAlert(title: "Ошибка", message: "Заполните поля ФИО, дата рождения, пол")
        }
    }
    
    @objc private func backButtonTapped() {
        
        let editUserModel = editingTableView.getUserModel()
        
        if editUserModel == userModel {
            navigationController?.popViewController(animated: true)
        } else {
            presentChangeAlert { [weak self] value in
                guard let self = self else { return }
                if value {
                    
                    guard let firstVC = self.navigationController?.viewControllers.first as? MainViewController else {
                        return
                    }
                    firstVC.changeUserModel(model: editUserModel)
                    self.navigationController?.popViewController(animated: true)
                } else {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
    
    private func authFields(model: UserModel) -> Bool {
        if model.firstName == "Введите данные" ||
            model.secondName == "Введите данные" ||
            model.birthday == "" ||
            model.gender == "" ||
            model.gender == "Не указано" {
            return false
        }
        return true
    }
    
    private func addTaps() {
        let tapImageView = UITapGestureRecognizer(target: self, action: #selector(setUserPhoto))
        userPhotoImageView.isUserInteractionEnabled = true
        userPhotoImageView.addGestureRecognizer(tapImageView)
    }
    
    @objc private func setUserPhoto() {
        print("tap")
    }
}

// MARK: - Setup Layout

extension EditingViewController {
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            userPhotoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            userPhotoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userPhotoImageView.heightAnchor.constraint(equalToConstant: 100),
            userPhotoImageView.widthAnchor.constraint(equalToConstant: 100),
            
            editingTableView.topAnchor.constraint(equalTo: userPhotoImageView.bottomAnchor, constant: 10),
            editingTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            editingTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            editingTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
}
