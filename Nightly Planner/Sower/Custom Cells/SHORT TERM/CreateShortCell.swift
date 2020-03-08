//
//  CreateShortCell.swift
//  Nightly Planner
//
//  Created by Drew Foster on 3/28/19.
//  Copyright © 2019 Drew Foster. All rights reserved.
//

import UIKit
import Foundation

class CreateShortCell: UICollectionViewCell {
    
    let goalTextField : UITextField = {
        let view = UITextField()
        view.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: view.frame.height))
        view.leftViewMode = .always
        view.layer.cornerRadius = 5
        view.adjustsFontSizeToFitWidth = true
        view.minimumFontSize = 0.2
        view.placeholder = "Goal title"
        view.textColor = .black
        view.font = UIFont(name: "Helvetica Neue", size: 40)
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear //UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1.0)
        return view
    }()
    
    let addGoal : UIButton = {
        let view = UIButton()
        view.layer.borderWidth = CGFloat(2)
        view.layer.borderColor = UIColor.gray.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.isHidden = false
        view.backgroundColor = UIColor(r: 40, g: 43, b: 53)
        view.addTarget(self, action: #selector(handleAddGoal), for: .touchUpInside)
        return view
    }()
    
    let categoryView : UIImageView = {
        let view = UIImageView()
        view.backgroundColor = UIColor(r: 40, g: 43, b: 53)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "add")
        view.isHidden = false
        view.tintImageColor(color: .white)
        return view
    }()
    
    
    override func draw(_ rect: CGRect) { //Your code should go here.
        super.draw(rect)
        self.layer.cornerRadius = 20
        addGoal.layer.cornerRadius = self.frame.size.height / 4
        
    }
    
    override func layoutSubviews() {
        addGoal.layer.cornerRadius = self.addGoal.frame.width / 2
    }
    
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.clipsToBounds = true
        addGoal.layer.cornerRadius = self.addGoal.frame.width / 2

        //self.selectionStyle = .none
        
        setupViews()
        setupConstraints()
        setupToolbar()
    }
    
    @objc func dismissKeyboard() {
        self.endEditing(true)
    }
    
    func setupToolbar() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(dismissKeyboard))
        toolbar.setItems([doneButton], animated: false)
        
        goalTextField.inputAccessoryView = toolbar
    }
    
    func setupViews() {
        self.contentView.addSubview(addGoal)
        addGoal.addSubview(categoryView)
    
        self.contentView.addSubview(goalTextField)
    }
    
    func setupConstraints() {
        addGoal.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5).isActive = true
        addGoal.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5).isActive = true
        addGoal.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        addGoal.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -12).isActive = true
        
        categoryView.widthAnchor.constraint(equalTo: addGoal.widthAnchor, multiplier: 0.55).isActive = true
        categoryView.heightAnchor.constraint(equalTo: addGoal.heightAnchor, multiplier: 0.55).isActive = true
        categoryView.centerYAnchor.constraint(equalTo: addGoal.centerYAnchor, constant: 0).isActive = true
        categoryView.centerXAnchor.constraint(equalTo: addGoal.centerXAnchor, constant: 0).isActive = true
        
        goalTextField.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        goalTextField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12).isActive = true
        goalTextField.rightAnchor.constraint(equalTo: self.addGoal.leftAnchor, constant: -12).isActive = true
        goalTextField.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.85).isActive = true
    }
    
    @objc func handleAddGoal(sender: UIButton) {
        print("Selected")
        if (goalTextField.text?.isEmpty)! {
            alert(message: "Text is empty")
        } else {
            alert(message: goalTextField.text ?? "Could not read value")
        }
    }
    
    func alert(message: String) {
        let myAlert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertController.Style.alert)
        
        let okAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil)
        
        myAlert.addAction(okAction)
        
        UIApplication.shared.keyWindow?.rootViewController?.present(myAlert, animated: true, completion: nil)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
