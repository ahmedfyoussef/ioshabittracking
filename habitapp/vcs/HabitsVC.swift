//
//  HabitsVC.swift
//  habitapp
//
//  Created by Ahmed Farid Youssef on 30/11/2024.
//

import UIKit

class HabitsVC: UIViewController {
    
    // Initialize Views
    var titletv  :UILabel = {
        let label = UILabel()
         label.backgroundColor = .clear
         label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var habitnameet:UITextField = {
        var lightgrey2 = UIColor(rgb: 0xeff0f5)

        let txtField = UITextField()
        var lightgrey = UIColor(rgb: 0xd9e2e7)
        let bkgdcolor = UIColor(rgb: 0xf9fafc)

       txtField.backgroundColor = bkgdcolor

        
        txtField.translatesAutoresizingMaskIntoConstraints = false
        txtField.layer.borderWidth = 2
        txtField.layer.borderColor = UIColor.gray.cgColor
        return txtField
    }()
    var addiv:UIImageView = {
       let imagename = "add.png"
      let imageview = UIImage(named: imagename)
     let addimage = UIImageView(image: imageview)
        addimage.translatesAutoresizingMaskIntoConstraints = false
     
     

      return addimage
    }()
    
    var habitstableview : UITableView = {
        let tv = UITableView()
       // tv.separatorStyle = .singleLine
        tv.allowsSelection = true
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
        }()
    
    
    //activity indicator used to show the progress of getting data from database

    var activityView = UIActivityIndicatorView(style: .gray)
    // initialize empty list to store retreived habits in it
    
    
    //Initialize Variables
    var isActive = true   //used to handle app life cycle specially when app is in the background
    var habits = [Habit]()
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }

    override func viewWillAppear(_ animated: Bool) {
        
        
        
        setupviews()

    }
    override func viewWillDisappear(_ animated: Bool) {
        setviewinactive()
    }
    override func viewDidDisappear(_ animated: Bool) {
        setviewinactive()
    }
    
    func setviewactive() {
        isActive = true
        print("view active")

    }
    func setviewinactive(){
  
        isActive = false
        print("view inactive")
    }
    func setupviews(){
        setviewactive()
        setupbackgroudviewsettings()
        setuptitletv()
        setuphabitnameet()
        setupaddiv()
        setuphabitstableview()
        setupactivityview()

    }
    // handle main view features
    func setupbackgroudviewsettings(){
        view.backgroundColor = .white
        
        //this is used to close the keyboard by touching the background view
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        let notificationCenter = NotificationCenter.default
         notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
         
         notificationCenter.addObserver(self, selector: #selector(appCameToForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
       
    }
    @objc func appMovedToBackground() {
        setviewinactive()
   }

   @objc func appCameToForeground() {
       setviewactive()
   }
    @objc func dismissKeyboard() {

        view.endEditing(true)
    }
    func setuptitletv(){
        view.addSubview(titletv)
        
        titletv.topAnchor.constraint(equalTo:   view.topAnchor, constant: UIApplication.shared.statusBarFrame.height).isActive = true
        
        titletv.leftAnchor.constraint(equalTo: view.leftAnchor , constant: 40  ).isActive = true
        titletv.rightAnchor.constraint(equalTo: view.rightAnchor , constant: -40  ).isActive = true
        titletv.font.withSize(17)
        titletv.text = "Habits"
        titletv.font = UIFont.boldSystemFont(ofSize: 25.0)
        titletv.textAlignment = .left
        titletv.textColor = .darkGray

        }
    func setuphabitnameet(){
        view.addSubview(habitnameet)
        habitnameet.attributedPlaceholder = NSAttributedString(string: " Add new habit...",
                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        habitnameet.topAnchor.constraint(equalTo:titletv.bottomAnchor, constant:30).isActive = true
        
        habitnameet.leftAnchor.constraint(equalTo: view.leftAnchor , constant: 30).isActive = true
        habitnameet.rightAnchor.constraint(equalTo: view.rightAnchor , constant: -80).isActive = true

        habitnameet.heightAnchor.constraint(equalToConstant: 50).isActive = true
        habitnameet.textColor = UIColor.black
        habitnameet.font?.withSize(17)

    }
    
    func setupaddiv(){
        view.addSubview(addiv)
        addiv.centerYAnchor.constraint(equalTo: habitnameet.centerYAnchor).isActive = true
        addiv.heightAnchor.constraint(equalToConstant: 30).isActive = true
        addiv.widthAnchor.constraint(equalToConstant: 30).isActive = true
        addiv.leftAnchor.constraint(equalTo:habitnameet.rightAnchor, constant:20).isActive = true
        let tapRecogniser = UITapGestureRecognizer(target: self, action: #selector(addivclicked))
        
        addiv.isUserInteractionEnabled = true
        addiv.addGestureRecognizer(tapRecogniser)
    }
    @objc func addivclicked() {
        print("add btn clicked")
   }
    
    func setuphabitstableview(){
        
    
        view.addSubview(habitstableview)
        habitstableview.frame = self.view.frame
        habitstableview.separatorColor = UIColor.clear
        habitstableview.backgroundColor = UIColor.clear
        habitstableview.delegate = self
        habitstableview.dataSource = self
        habitstableview.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        habitstableview.topAnchor.constraint(equalTo:habitnameet.bottomAnchor, constant:20).isActive = true
        
        habitstableview.bottomAnchor.constraint(equalTo:view.bottomAnchor,constant: -50).isActive = true
        habitstableview.leftAnchor.constraint(equalTo:view.leftAnchor, constant:20).isActive = true
        habitstableview.rightAnchor.constraint(equalTo:view.rightAnchor, constant:-20).isActive = true
        DispatchQueue.main.async {
             self.habitstableview.reloadData()
            
            
         }
       
        //this is used to close the keyboard when touching or scrolling the tableview 
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        habitstableview.addGestureRecognizer(tap)
       
        habitstableview.register(HabitCell.self, forCellReuseIdentifier: "HabitCell")
    }
    func setupactivityview() {

        view.addSubview(activityView)
        
       
        activityView.translatesAutoresizingMaskIntoConstraints = false
        activityView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        activityView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        activityView.heightAnchor.constraint(equalToConstant: 100).isActive = true

        
         activityView.hidesWhenStopped = true
        activityView.color = .gray
    }
    

}
extension HabitsVC  : UITableViewDelegate , UITableViewDataSource ,HabitCellDelegate
{
    func didtapcheck(tappedIndex: IndexPath, status: Bool) {
        print("checkbox clicked")
 
        
    }
    
    func didtapdelete(tappedIndex: IndexPath) {
        print("deletebtn clicked")

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.habits.count
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let habit = self.habits[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "HabitCell", for: indexPath) as! HabitCell
        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        cell.selectedBackgroundView = backgroundView
        
        cell.sethabitinfo(habit: habit)
        cell.contentView.isUserInteractionEnabled = false
        cell.myIndexPath = indexPath
        cell.deletedelegate = self
        cell.checkdelegate = self
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
}
