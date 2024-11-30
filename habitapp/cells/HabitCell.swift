//
//  HabitCell.swift
//  habit
//
//  Created by Ahmed Farid Youssef on 30/11/2024.
//

import Foundation
import UIKit
protocol HabitCellDelegate : class {
    func didtapcheck(tappedIndex: IndexPath ,   status : Bool )
   func didtapdelete(tappedIndex: IndexPath )
}
class HabitCell: UITableViewCell {
    
    var myIndexPath:IndexPath!

    weak var deletedelegate : HabitCellDelegate?
    weak var checkdelegate : HabitCellDelegate?
    var deletebtn:UIImageView = {
       let imagename = "delete"
       let imageview = UIImage(named: imagename)
       let deleteimage = UIImageView(image: imageview)
        deleteimage.translatesAutoresizingMaskIntoConstraints = false
      return deleteimage
    }()
    lazy var backview: UIView = {

        let bkgdcolor = UIColor(rgb: 0xf9fafc)

        let view = UIView()
        var grey = UIColor(rgb: 0xd9e2e7)
        view.backgroundColor = .white
        view.layer.borderWidth = 1
        
         view.layer.borderColor = grey.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false

        
           return view
       }()
    
    var habitnametv  :UILabel = {
       let label = UILabel()
        label.numberOfLines = 0
        label.sizeToFit()
        label.backgroundColor = .clear
        label.numberOfLines = 0
        label.sizeToFit()
        label.textColor = UIColor.black
      
       label.translatesAutoresizingMaskIntoConstraints = false
       return label
   }()
    var checkboxbtn: UIButton = {
        let button = UIButton(type: .custom) // Custom button type
        

        let checkedImage = UIImage(named: "checked.png")
        let uncheckedImage = UIImage(named: "unchecked.png")
        
        button.setImage(uncheckedImage, for: .normal)
        
        button.setImage(checkedImage, for: .selected)
        
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(toggleCheckbox), for: .touchUpInside)
        
        
        return button
    }()
    
    @objc func toggleCheckbox() {
        checkboxbtn.isSelected = !checkboxbtn.isSelected
        deletedelegate?.didtapcheck(tappedIndex:self.myIndexPath  , status : checkboxbtn.isSelected )

    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
         
        setupviews()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.backgroundColor =  UIColor.clear
        backgroundColor = UIColor.clear
  
        
       
    }
   
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")

        
    }
 
    
    func setupviews(){
        
        setupbackview()
        
        setupcheckbox()
        setupdeletebtn()
        setuphabitnametv()
        
    }
    
    func setupbackview(){
        addSubview(backview)
        
        backview.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 10).isActive = true
        backview.rightAnchor.constraint(equalTo: self.rightAnchor , constant: -10).isActive = true
        backview.bottomAnchor.constraint(equalTo: self.bottomAnchor , constant:  -5).isActive = true

        backview.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
    }
    func  setupcheckbox(){
      addSubview(checkboxbtn)
        checkboxbtn.widthAnchor.constraint(equalToConstant: 30).isActive = true

        checkboxbtn.heightAnchor.constraint(equalToConstant: 30).isActive = true
 
        checkboxbtn.leftAnchor.constraint(equalTo:backview.leftAnchor , constant: 20).isActive = true
        checkboxbtn.centerYAnchor.constraint(equalTo:backview.centerYAnchor ).isActive = true
      }
 
    
    func  setupdeletebtn(){
        addSubview(deletebtn)
        deletebtn.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        deletebtn.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        deletebtn.rightAnchor.constraint(equalTo:backview.rightAnchor , constant: -20).isActive = true
        deletebtn.centerYAnchor.constraint(equalTo:backview.centerYAnchor ).isActive = true
        
        let tapRecogniser = UITapGestureRecognizer(target: self, action: #selector(deletebtnpressed))
         
        deletebtn.isUserInteractionEnabled = true
        deletebtn.addGestureRecognizer(tapRecogniser)
    }
    @objc func deletebtnpressed(){
        deletedelegate?.didtapdelete(tappedIndex:self.myIndexPath)
    }
    func setuphabitnametv(){
         addSubview(habitnametv)
        habitnametv.leftAnchor.constraint(equalTo: checkboxbtn.rightAnchor , constant: 20 ).isActive = true
        habitnametv.rightAnchor.constraint(equalTo: deletebtn.leftAnchor , constant: -20).isActive = true
      //  habitnametv.heightAnchor.constraint(equalToConstant: 60).isActive = true

        habitnametv.topAnchor.constraint(equalTo: self.topAnchor, constant: 15).isActive = true
        habitnametv.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15).isActive = true
        habitnametv.textAlignment = .left
        habitnametv.font.withSize(17)
         
         
        habitnametv.textColor = .darkGray
    

    }
    
    
    func sethabitinfo(habit : Habit){
     
        self.habitnametv.text = habit.habit
        
        self.checkboxbtn.isSelected = habit.status
    }

    override func prepareForReuse() {
        super.prepareForReuse()
       
        habitnametv.text = nil
       
       
       
    }
}
