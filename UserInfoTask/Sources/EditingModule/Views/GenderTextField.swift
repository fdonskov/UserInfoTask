//
//  GenderTextField.swift
//  UserInfoTask
//
//  Created by Федор Донсков on 13.11.2022.
//

import UIKit

class GenderTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
//        placeholder = "Введите данные"
        textAlignment = .right
        tintColor = .clear
        font = Resources.Fonts.avenirNextRegular(with: 18)
        let font = Resources.Fonts.avenirNextRegular(with: 18)
        attributedPlaceholder = NSAttributedString(string: "Введите данные", attributes: [.foregroundColor : UIColor.lightGray, .font : font as AnyObject])
    }
    
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        !isFirstResponder
    }
}
