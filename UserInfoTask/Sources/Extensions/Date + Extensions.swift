//
//  Date + Extensions.swift
//  UserInfoTask
//
//  Created by Федор Донсков on 14.11.2022.
//

import Foundation

extension Date {
    
    func getStringFromDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let dateString = dateFormatter.string(from: self)
        return dateString
    }
}
