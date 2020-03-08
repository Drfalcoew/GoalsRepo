//
//  SelectedTaskCellView.swift
//  Sower
//
//  Created by Drew Foster on 3/2/20.
//  Copyright © 2020 Drew Foster. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class SelectedTaskCellView : UIViewController {
    
    var selectedTask : Int?
    var tasks : [NSManagedObject] = [NSManagedObject]()
    var task_routine : Bool?
    var name : String = ""
    
    var date: String?
    var completed: Bool?
    var daysTaken: Int?
    var category : Int?

    var daysPassedLabel : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.font = UIFont(name: "Helvetica Neue", size: 20)
        lbl.textColor = UIColor(r: 75, g: 80, b: 120)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.2
        lbl.text = "Days since creation: "
        return lbl
    }()
    
    var completedLabel : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.font = UIFont(name: "Helvetica Neue", size: 20)
        lbl.textColor = UIColor(r: 255, g: 89, b: 89)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.2
        lbl.text = "Incomplete"
        return lbl
    }()
    
    var categoryLabel : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.font = UIFont(name: "Helvetica Neue", size: 20)
        lbl.textColor = UIColor(r: 75, g: 80, b: 120)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.2
        lbl.text = "Category: "
        return lbl
    }()
    
    var categoryView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        return view
    }()
    
    var nameLabel : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.backgroundColor = .green
        lbl.textAlignment = .center
        return lbl
    }()
    
    let titleView : GreetingViewSubclass = {
        let view = GreetingViewSubclass()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupAttributes()
        setupNavigation()
        setupViews()
        setupConstraints()
    }
    
    func setupNavigation() {
        //navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue): UIColor(r: 75, g: 80, b: 120)]
        
    }
    
    func setupAttributes() {
        
        titleView.titleLabel.text = name
        
        daysTaken = date?.toDate()?.days(from: Date())
        if daysTaken != nil {
            daysTaken = daysTaken! * -1
        }
        daysPassedLabel.text = "Days since creation: \(daysTaken ?? 0)"
        
        
        if task_routine! {
            titleView.subLabel_0.text = "One-time task"
            titleView.subLabelImage.image = UIImage(named: "task")
            titleView.subLabelImage.tintImageColor(color: UIColor(r: 75, g: 80, b: 120))
        }
        
        print(name)
    }
    
    func setupViews() {
        //self.view.addSubview(nameLabel)
        self.view.addSubview(titleView)
        self.view.addSubview(daysPassedLabel)
        self.view.addSubview(completedLabel)
        self.view.addSubview(categoryLabel)
    }
    
    func setupConstraints() {
        /*nameLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 10).isActive = true
        nameLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1/3).isActive = true
        nameLabel.heightAnchor.constraint(equalTo: self.nameLabel.widthAnchor, multiplier: 2/3).isActive = true
        nameLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true*/
        
        titleView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        titleView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1/8.5).isActive = true
        titleView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9).isActive = true
        titleView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: (navigationController?.navigationBar.frame.height ?? 60) + self.view.frame.height * 0.035).isActive = true
        
        completedLabel.topAnchor.constraint(equalTo: self.titleView.bottomAnchor, constant: 10).isActive = true
        completedLabel.leftAnchor.constraint(equalTo: self.titleView.leftAnchor, constant: self.view.frame.width * 0.1).isActive = true
        completedLabel.heightAnchor.constraint(equalTo: self.titleView.heightAnchor, multiplier: 4/5).isActive = true
        completedLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        
        daysPassedLabel.topAnchor.constraint(equalTo: self.completedLabel.bottomAnchor, constant: 0).isActive = true
        daysPassedLabel.leftAnchor.constraint(equalTo: self.titleView.leftAnchor, constant: self.view.frame.width * 0.1).isActive = true
        daysPassedLabel.heightAnchor.constraint(equalTo: self.titleView.heightAnchor, multiplier: 4/5).isActive = true
        daysPassedLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        
        categoryLabel.topAnchor.constraint(equalTo: self.daysPassedLabel.bottomAnchor, constant: 0).isActive = true
        categoryLabel.leftAnchor.constraint(equalTo: self.titleView.leftAnchor, constant: self.view.frame.width * 0.1).isActive = true
        categoryLabel.heightAnchor.constraint(equalTo: self.titleView.heightAnchor, multiplier: 4/5).isActive = true
        categoryLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
