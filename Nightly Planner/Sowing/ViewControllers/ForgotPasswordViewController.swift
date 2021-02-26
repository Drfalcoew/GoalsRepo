//
//  ForgotPasswordViewController.swift
//  Nightly Planner
//
//  Created by Drew Foster on 3/18/19.
//  Copyright © 2019 Drew Foster. All rights reserved.
//

import Foundation
import UIKit
//import Firebase

class ForgotPasswordViewController: UIViewController {    
    
    var toolBar : UIToolbar?
    
    let okButton : UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 2
        btn.backgroundColor = UIColor(r: 125, g: 200, b: 180)
        btn.setTitle("Reset Password", for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.masksToBounds = true
        return btn
    }()
    
    let forgotPasswordLbl : UILabel = {
        let lbl = UILabel()
        lbl.text = "Enter Email"
        lbl.textAlignment = .center
        lbl.font = UIFont(name: "Helvetica Neue", size: 20)
        lbl.font = UIFont.boldSystemFont(ofSize: 20)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.textColor = UIColor(r: 221, g: 221, b: 221)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        return lbl
    }()
    
    let emailTextField : UITextField = {
        let text = UITextField()
        text.placeholder = "Email"
        text.layer.cornerRadius = 5
        text.backgroundColor = UIColor(r: 221, g: 221, b: 221)
        text.translatesAutoresizingMaskIntoConstraints = false
        text.layer.masksToBounds = true
        text.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: text.frame.height))
        text.leftViewMode = .always
        return text
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        self.navigationController?.navigationBar.shadowImage = nil
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.view.backgroundColor = UIColor(r: 221, g: 221, b: 221)
        
        
        /*let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginController.dismissKeyboard))
        view.addGestureRecognizer(tap)*/

        self.title = "Reset Password"
        
        setupToolbar()
        setupViews()
        setupConstraints()
    }
    
    func setupToolbar() {
        toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 50))
        toolBar!.barStyle = UIBarStyle.default
        
        toolBar!.items = [
            UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(dismissKeyboard)),
        ]
        toolBar!.sizeToFit()
        
        emailTextField.inputAccessoryView = toolBar
    }
    
    
    func setupViews() {
        self.view.addSubview(okButton)
        self.view.addSubview(forgotPasswordLbl)
        self.view.addSubview(emailTextField)
    }
    
    func setupConstraints() {
        
        forgotPasswordLbl.topAnchor.constraint(equalTo: self.view.topAnchor, constant: (navigationController?.navigationBar.frame.height ?? 60) + 40).isActive = true
        forgotPasswordLbl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        forgotPasswordLbl.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9).isActive = true
        forgotPasswordLbl.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        emailTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        emailTextField.topAnchor.constraint(equalTo: forgotPasswordLbl.bottomAnchor, constant: 10).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.6).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        okButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        okButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        okButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1, constant: 0).isActive = true
        okButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/8).isActive = true
    }
    
    
    func alert(message: String) {
        let myAlert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertController.Style.alert)
        let cancelAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        
        myAlert.addAction(cancelAction)
        present(myAlert, animated: true, completion: nil)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
}
