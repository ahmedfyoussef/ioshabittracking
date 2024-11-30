//
//  Habit.swift
//  habit
//
//  Created by Ahmed Farid Youssef on 30/11/2024.
//

import Foundation




class Habit {
    var habitid : String

    var habit : String
    var status : Bool
    
    
    init(habitid : String , habit : String , status : Bool ) {
        self.habitid = habitid
        self.habit = habit
 
        
        self.status = status
 
    }
}
