//
//  Network.swift
//   
//
//  Created by Ahmed Farid Youssef on 30/11/2024.
//

import Foundation
import FirebaseDatabase

class Network {
    
    static let shared = Network()
    
    private let ref = Database.database().reference()
    
    // This to return the habits once they are fetched
    func fetchHabits( completion: @escaping ([Habit]) -> Void) {
        ref.child("userhabits").observe(.value) { snapshot in
            var habits: [Habit] = []
            
            for habitChild in snapshot.children {
                if let habitSnap = habitChild as? DataSnapshot,
                   let dict = habitSnap.value as? [String: Any] {
                    
                    let habitid = dict["habitid"] as? String ?? ""
                    let habitname = dict["habit"] as? String ?? ""
                    let status = dict["status"] as? Bool ?? false
                    
                    let habit = Habit(habitid: habitid, habit: habitname, status: status)
                    habits.append(habit)
                }
            }
            
             
            completion(habits)
        }
    }
    
    func insertnewhabit(habitname : String , completion: @escaping (Bool, Error?) -> Void) {
        let habitid  = UUID().uuidString

        let habitdict = [      "habit":habitname ,
                              "habitid": habitid ,
                             "status" : false
                               
                                                
                               ] as [String : Any]
        
        let habitRef = ref.child("userhabits").child(habitid)
        
        // update habit status by id
        habitRef.setValue(habitdict) { error, _ in
            if let error = error {

                completion(false, error)
            } else {

                completion(true, nil)
            }
        }
    }
    
    func updatestatus(habitid habitid: String, status: Bool, completion: @escaping (Bool, Error?) -> Void) {
        
        let habitRef = ref.child("userhabits").child(habitid).child("status")
        
        // update habit status by id
        habitRef.setValue(status) { error, _ in
            if let error = error {

                completion(false, error)
            } else {

                completion(true, nil)
            }
        }
    }
    func deletehabit(habitid habitid: String, completion: @escaping (Bool, Error?) -> Void) {

        let habitRef = ref.child("userhabits").child(habitid)
        
        //delete habit by id
        habitRef.removeValue() { error, _ in
            if let error = error {
               
                
                completion(false, error)
            } else {

                completion(true, nil)
            }
        }
    }
}
