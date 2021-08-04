//
//  FeedbackViewController.swift
//  Nightly Planner
//
//  Created by Drew Foster on 6/12/19.
//  Copyright © 2019 Drew Foster. All rights reserved.
//

import UIKit
//import GoogleMobileAds
import MessageUI
//import Firebase

class FeedbackViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    var topViewHeightAnchor: NSLayoutConstraint?
    
    let inputsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 240, g: 240, b: 240)

        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 5
        return view
    }()
    
    let SubjectTextField: UITextField = {
        let txt = UITextField()
        txt.backgroundColor = .clear  //UIColor(r: 230, g: 230, b: 230)
        txt.placeholder = "Subject"
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.textColor = .black
        //txt.layer.masksToBounds = true
        //txt.layer.cornerRadius = 5
        return txt
    }()
    
    let emailSeparatorView: UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = false
        view.backgroundColor = UIColor(r: 200, g: 200, b: 200)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let feedbackField: UITextField = {
        let txt = UITextField()
        //txt.backgroundColor = UIColor.white
        txt.contentVerticalAlignment = .top
        txt.placeholder = "Feedback"
        txt.backgroundColor = .clear
        txt.textColor = .black
        txt.translatesAutoresizingMaskIntoConstraints = false
        //txt.layer.masksToBounds = true
        //txt.layer.cornerRadius = 5
        return txt
    }()
    
    let submitButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Submit", for: .normal)
        btn.backgroundColor = UIColor(r: 75, g: 80, b: 120)
        btn.setTitleColor(UIColor.white, for: UIControl.State())
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        btn.layer.cornerRadius = 2
        btn.addTarget(self, action: #selector(submitButtonPressed), for: .touchUpInside)
        return btn
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
        
        self.title = "Feedback"
        
        setupToolbar()
        setupViews()
        setupConstraints()
    }
    
    func setupToolbar() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(dismissKeyboard))
        
        toolbar.setItems([doneButton], animated: false)
        
        feedbackField.inputAccessoryView = toolbar
        SubjectTextField.inputAccessoryView = toolbar
        
    }
    
    func setupViews() {
        view.addSubview(inputsContainerView)
        view.addSubview(submitButton)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(FeedbackViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func setupConstraints() {
        
        
        inputsContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputsContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -25).isActive = true
        inputsContainerView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        inputsContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        
        
        inputsContainerView.addSubview(SubjectTextField)
        inputsContainerView.addSubview(emailSeparatorView)
        inputsContainerView.addSubview(feedbackField)
        
        
        
        SubjectTextField.topAnchor.constraint(equalTo: inputsContainerView.topAnchor).isActive = true
        SubjectTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        SubjectTextField.rightAnchor.constraint(equalTo: inputsContainerView.rightAnchor, constant: -12).isActive = true
        SubjectTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        
        emailSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        emailSeparatorView.rightAnchor.constraint(equalTo: inputsContainerView.rightAnchor).isActive = true
        emailSeparatorView.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        emailSeparatorView.topAnchor.constraint(equalTo: SubjectTextField.bottomAnchor).isActive = true
        
        
        feedbackField.topAnchor.constraint(equalTo: emailSeparatorView.bottomAnchor, constant: 10).isActive = true
        feedbackField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        feedbackField.rightAnchor.constraint(equalTo: inputsContainerView.rightAnchor, constant: -12).isActive = true
        feedbackField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        feedbackField.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        submitButton.topAnchor.constraint(equalTo: inputsContainerView.bottomAnchor, constant: 20).isActive = true
        submitButton.centerXAnchor.constraint(equalTo: feedbackField.centerXAnchor).isActive = true
        submitButton.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        submitButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
        
    }
    
    func displayAlert(_ userMessage: String){
        
        let myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        myAlert.addAction(okAction)
        self.present(myAlert, animated: true, completion: nil)
    }
    
    @objc func submitButtonPressed() {
        if (SubjectTextField.text?.isEmpty == true || feedbackField.text?.isEmpty == true){
            displayAlert("One or more text fields are empty")
        }
        else {
            sendEmail()
        }
    }
    
    func sendEmail(){
                
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["zlistteam@gmail.com"])
            mail.setSubject(SubjectTextField.text!)
            mail.setMessageBody("<p>\(feedbackField.text!)</p>", isHTML: true)
            present(mail, animated: true, completion: {
                self.SubjectTextField.text = ""
                self.feedbackField.text = ""
            })
        } else {
            displayAlert("Error sending feedback")
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true) {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "feedbackAlert"), object: nil)
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
