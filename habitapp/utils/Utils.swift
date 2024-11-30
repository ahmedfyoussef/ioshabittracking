//
//  Utils.swift
//  habitapp
//
//  Created by Ahmed Farid Youssef on 01/12/2024.
//

import Foundation



 
class Utils {

    static func getCurrentDate() -> String {
        let currentDate = Date()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return dateFormatter.string(from: currentDate)
    }
}
