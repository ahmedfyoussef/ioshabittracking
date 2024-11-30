//
//  ViewController.swift
//  habitapp
//
//  Created by Ahmed Farid Youssef on 30/11/2024.
//

import UIKit
import FirebaseDatabase
class ViewController: UIViewController {
    var ref: DatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        ref = Database.database().reference()
        ref.child("testios").setValue(true)
    }


}

