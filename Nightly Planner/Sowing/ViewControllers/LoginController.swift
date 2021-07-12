//  LoginController.swift
//  Nightly Planner
//
//  Created by Drew Foster on 12/12/18.
//  Copyright © 2018 Drew Foster. All rights reserved.
//

import UIKit
import Foundation
/*
import Firebase
import FirebaseDatabase
import GoogleMobileAds

class LoginController: UIViewController {
    
    var user: [User] = []
    var centerY : CGFloat!
    var toolBar : UIToolbar?
    var db : Firestore?
    
    var registerButton : UIBarButtonItem?
    var loginButton : UIBarButtonItem?
    
    var privacyPolicyBtn : UIButton = {
        let btn = UIButton()
        btn.setTitle("Privacy Policy", for: .normal)
        btn.layer.masksToBounds = true
        btn.titleLabel?.adjustsFontSizeToFitWidth = true
        btn.titleLabel?.textAlignment = .center
        btn.titleLabel?.minimumScaleFactor = 0.2
        btn.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 20)
        btn.addTarget(self, action: #selector(privacyPolicy), for: .touchUpInside)
        btn.setTitleColor(.white, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    var bannerView: GADBannerView!
    
    var nameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Username"
        tf.backgroundColor = UIColor(r: 240, g: 240, b: 240)
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: tf.frame.height))
        tf.leftViewMode = .always
        tf.textColor = .black
        tf.text = tf.text?.removeWhitespaces()
        return tf
    }()
    
    let nameSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 221, g: 221, b: 221)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var icon = UIImageView()
    
    var subTitle : UILabel = {
        let lbl = UILabel()
        lbl.text = "By failing to prepare, you are preparing to fail. - Benjamin Franklin"
        lbl.textColor = UIColor(r: 221, g: 221, b: 221)
        lbl.textAlignment = .center
        
        lbl.adjustsFontSizeToFitWidth = true
        lbl.numberOfLines = 2
        lbl.lineBreakMode = .byTruncatingTail
        lbl.minimumScaleFactor = 0.2
        lbl.font = UIFont(name: "Helvetica Neue", size: 36)
        lbl.isHidden = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        return lbl
    }()
    
    var emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.keyboardType = .emailAddress
        tf.backgroundColor = UIColor(r: 230, g: 230, b: 230)
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.autocapitalizationType = UITextAutocapitalizationType.none
        tf.text = tf.text?.removeWhitespaces()
        tf.textColor = .black
        tf.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: tf.frame.height))
        tf.leftViewMode = .always
        return tf
    }()
    
    let emailSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    var passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.isSecureTextEntry = true
        tf.backgroundColor = UIColor(r: 221, g: 221, b: 221)
        tf.text = tf.text?.removeWhitespaces()
        tf.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: tf.frame.height))
        tf.leftViewMode = .always
        tf.textColor = .black
        return tf
    }()
    
    let forgotPassword: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .clear
        btn.setTitle("Forgot?", for: UIControl.State.normal)
        btn.layer.cornerRadius = 2
        btn.setTitleColor(UIColor(r: 40, g: 43, b: 53), for: UIControl.State.normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.masksToBounds = true
        btn.isHidden = true
        btn.addTarget(self, action: #selector(handleForgotPassword), for: .touchUpInside)
        return btn
    }()
    
    let inputsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 2
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var loginRegisterSegmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Login", "Register"])
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.tintColor = UIColor(r: 125, g: 200, b: 180)
        sc.selectedSegmentIndex = 1
        sc.addTarget(self, action: #selector(handleLoginRegisterChange), for: .valueChanged)
        return sc
    }()
    
    lazy var loginRegisterButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(red: 125/255, green: 200/255, blue: 180/255, alpha: 1.0)
        button.setTitle("Register", for: UIControl.State())
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 2
        button.setTitleColor(UIColor(red: 221/255, green: 221/255, blue: 221/255, alpha: 1), for: UIControl.State())
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        button.addTarget(self, action: #selector(handleLoginRegister), for: .touchUpInside)
        
        return button
    }()
    
    override func viewDidAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        
        if let x = self.navigationController?.viewControllers.count {
           // self.navigationController?.viewControllers.removeFirst(x-1)
            print("Removing the last \(x-1) viewControllers")
        }
        
        
        
    }
    
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
        self.tabBarController?.tabBar.isHidden = true
        self.view.backgroundColor = .clear//UIColor(r: 40, g: 43, b: 53)
        //NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear), name: UIResponder.keyboardWillHideNotification, object: nil)
        //NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        centerY = self.view.center.y
        
        icon.image = UIImage(named: "icon")
        navigationItem.titleView = icon

        bannerView = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait)
        bannerView.adUnitID = "ca-app-pub-8752347849222491/3619894003"
        
        
        bannerView.rootViewController = self
        //bannerView.load(GADRequest())
        
        normalAlert(title: "Welcome! Please login or register.", message: "\"By failing to prepare, you are preparing to fail.\" - Benjamin Franklin")
        
        setupDatabase()
        addBannerViewToView()
        setupToolbar()
        setupNavigationBar()
        setupViews()
        setupConstraints()
    }
    
    func setupDatabase() {
        db = Firestore.firestore()
        let settings = db?.settings
        //settings?.areTimestampsInSnapshotsEnabled = true
        db?.settings = settings!
    }
    
    func setupNavigationBar() {
        navigationController?.navigationBar.topItem?.hidesBackButton = true
        navigationController?.navigationBar.barTintColor = UIColor(r: 40, g: 43, b: 53)
        navigationController?.navigationBar.tintColor = UIColor(r: 221, g: 221, b: 221)
        
        self.title = "QuestLine"
    }
    
    var inputsContainerViewHeightAnchor: NSLayoutConstraint?
    var nameTextFieldHeightAnchor: NSLayoutConstraint?
    var emailTextFieldHeightAnchor: NSLayoutConstraint?
    var passwordTextFieldHeightAnchor: NSLayoutConstraint?
    
    func setupConstraints() {
        
        loginRegisterSegmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginRegisterSegmentedControl.topAnchor.constraint(equalTo: self.view.topAnchor, constant: (navigationController?.navigationBar.frame.height ?? 60) + (self.view.frame.height * 0.10)).isActive = true
        loginRegisterSegmentedControl.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor, multiplier: 1).isActive = true
        loginRegisterSegmentedControl.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: ((1/4.5)/3)/1.5).isActive = true
        
        inputsContainerView.topAnchor.constraint(equalTo: self.loginRegisterSegmentedControl.bottomAnchor, constant: 10).isActive = true
        inputsContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputsContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        inputsContainerViewHeightAnchor = inputsContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/4.5)
        inputsContainerViewHeightAnchor?.isActive = true
        
        nameTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 0).isActive = true
        nameTextField.topAnchor.constraint(equalTo: inputsContainerView.topAnchor).isActive = true
        
        nameTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        nameTextFieldHeightAnchor = nameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3)
        nameTextFieldHeightAnchor?.isActive = true
        
        //need x, y, width, height constraints
        nameSeparatorView.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        nameSeparatorView.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        nameSeparatorView.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        nameSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        //need x, y, width, height constraints
        emailTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 0).isActive = true
        emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        
        emailTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        
        emailTextFieldHeightAnchor = emailTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3)
        
        emailTextFieldHeightAnchor?.isActive = true
        
        //need x, y, width, height constraints
        emailSeparatorView.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        emailSeparatorView.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        emailSeparatorView.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        emailSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        //need x, y, width, height constraints
        passwordTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 0).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        passwordTextFieldHeightAnchor = passwordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3)
        passwordTextFieldHeightAnchor?.isActive = true
        
        forgotPassword.centerYAnchor.constraint(equalTo: passwordTextField.centerYAnchor, constant: 0).isActive = true
        forgotPassword.rightAnchor.constraint(equalTo: passwordTextField.rightAnchor, constant: -10).isActive = true
        forgotPassword.heightAnchor.constraint(greaterThanOrEqualToConstant: 0).isActive = true
        forgotPassword.widthAnchor.constraint(greaterThanOrEqualToConstant: 0).isActive = true
        
        loginRegisterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginRegisterButton.topAnchor.constraint(equalTo: inputsContainerView.bottomAnchor, constant: 10).isActive = true
        loginRegisterButton.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        loginRegisterButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: ((1/4.5)/3)/1.5).isActive = true
        
        privacyPolicyBtn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        privacyPolicyBtn.topAnchor.constraint(equalTo: loginRegisterButton.bottomAnchor, constant: 12).isActive = true
        privacyPolicyBtn.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8/2).isActive = true
        privacyPolicyBtn.heightAnchor.constraint(equalToConstant: 55).isActive = true
    }
    
    func setupToolbar() {
        toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 50))
        toolBar!.barStyle = UIBarStyle.default
        registerButton = UIBarButtonItem(title: "Register", style: UIBarButtonItem.Style.plain, target: self, action: #selector(LoginController.handleRegister))

        toolBar!.items = [
            UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(dismissKeyboard)),
            UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil),
            registerButton!
        ]
        toolBar!.sizeToFit()
    
        nameTextField.inputAccessoryView = toolBar
        emailTextField.inputAccessoryView = toolBar
        passwordTextField.inputAccessoryView = toolBar
    }
    
    func setupViews() {
        self.view.addSubview(loginRegisterButton)
        self.view.addSubview(loginRegisterSegmentedControl)
        self.view.addSubview(inputsContainerView)
        self.view.addSubview(privacyPolicyBtn)
        
        inputsContainerView.addSubview(nameTextField)
        inputsContainerView.addSubview(nameSeparatorView)
        inputsContainerView.addSubview(emailTextField)
        inputsContainerView.addSubview(emailSeparatorView)
        inputsContainerView.addSubview(passwordTextField)
        
        self.passwordTextField.addSubview(forgotPassword)
    }
    
    
    @objc func handleLoginRegister() {
        print("In handleLoginRegister")
        
        
        if loginRegisterSegmentedControl.selectedSegmentIndex == 0 {
            if (passwordTextField.text == "" || emailTextField.text == ""){
                //displayAlert("One or more text fields are empty")
                return
            }
            else {
                handleLogin()
            }
        } else {
            if (passwordTextField.text == "" || emailTextField.text == "" || nameTextField.text == ""){
                //displayAlert("One or more text fields are empty")
                return
            }
            else {
                handleRegister()
            }
        }
    }
    
   
    
    @objc func handleLogin() {
        
        view.endEditing(true)
        
        alert(message: "Logging in")
        
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
            if error != nil {
                print(error as Any)
                self.dismiss(animated: true, completion: {
                    self.errorAlert(error: error?.localizedDescription ?? "An unknown error occured. Please try again.")
                })
                
                //self.dismiss(animated: true, completion: {
                    //self.displayAlert("Incorrect Login")
                //})
                return
            }
            UserDefaults.standard.set(user?.user.uid, forKey: "uid")
            self.dismiss(animated: true, completion: {
                print("POPPING TO ROOT")
                self.navigationController?.customPopToRoot()
            })
            //successfully logged in our user
            
        })
    }
    
    @objc func handleForgotPassword() {
        navigationController?.customPush(viewController: ForgotPasswordViewController())
    }
    
    
    
    @objc func handleRegister() {
        view.endEditing(true)
        alert(message: "Registering..")
        
        guard let email = emailTextField.text, let password = passwordTextField.text, let name = nameTextField.text else {
            self.dismiss(animated: true, completion: {
                self.errorAlert(error: "One or more text fields are empty.")
            })
            return
        }
        //print ("email: \(email), password: \(password), name: \(name)")
        
        
        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
            if error != nil {
                print(error as Any)
                
                self.dismiss(animated: true, completion: {
                    self.errorAlert(error: error?.localizedDescription ?? "An unknown error occured. Please try again.")
                })
                /*self.dismiss(animated: true, completion: {
                    self.displayAlert((error?.localizedDescription)!)
                })*/
                
            }
            
            guard let uid = user?.user.uid else {
                return
            }
            
            //successfully authenticated user
            
            
            let values = ["name": name, "email": email, "rep": 0.0] as [String : Any]
            self.registerUserIntoDatabaseWithUID(uid, values: values as [String : AnyObject])
            
            
            // dismissing register alert

            self.dismiss(animated: true, completion: {
                self.handleLogin()
            })
        })
    }
    
    
    func normalAlert(title: String, message: String) {
        let myAlert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let oK = UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil)
        
        myAlert.addAction(oK)
        present(myAlert, animated: true, completion: nil)
    }
    
    func alert(message: String) {
        let myAlert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertController.Style.alert)
        
        present(myAlert, animated: true, completion: nil)
    }
    
    func errorAlert(error: String) {
        let myAlert = UIAlertController(title: "Error!", message: error, preferredStyle: UIAlertController.Style.alert)
        let oK = UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil)
        
        myAlert.addAction(oK)
        present(myAlert, animated: true, completion: nil)
    }
    
    
    fileprivate func registerUserIntoDatabaseWithUID(_ uid: String, values: [String: AnyObject]) {
        
        
        db?.collection("users").document(uid).setData([
            "userName" : values["name"] ?? "Could not load userName",
            "email" : values["email"] ?? "Could not load email",
            "completed" : 0,
            "premium" : false
            //"rep" : values["rep"] ?? 0.0
        ])
        
        print(values)
        
        let loggedUser = User(uid: uid, email: self.emailTextField.text!, userName: self.nameTextField.text!, rep: 0.0)
        self.user.append(loggedUser)
            
            
            
            
            //user.setValuesForKeys(values)
    }
    
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    @objc func handleLoginRegisterChange(){
        
        emailTextField.text = ""
        nameTextField.text = ""
        passwordTextField.text = ""
        
        dismissKeyboard()
        
        if loginRegisterSegmentedControl.selectedSegmentIndex == 0 {
            nameTextField.placeholder = ""
            loginButton = UIBarButtonItem(title: "Login", style: UIBarButtonItem.Style.plain, target: self, action: #selector(LoginController.handleLogin))
            forgotPassword.isHidden = false
            
            var toolBarItems = self.toolBar?.items
            toolBarItems![2] = loginButton!
            self.toolBar?.setItems(toolBarItems, animated: true)
            
        }
        else {
            registerButton = UIBarButtonItem(title: "Register", style: UIBarButtonItem.Style.plain, target: self, action: #selector(LoginController.handleRegister))
            nameTextField.placeholder = "Username"
            forgotPassword.isHidden = true
            
            var toolBarItems = self.toolBar?.items
            toolBarItems![2] = registerButton!
            self.toolBar?.setItems(toolBarItems, animated: true)
        }
        
        let title = loginRegisterSegmentedControl.titleForSegment(at: loginRegisterSegmentedControl.selectedSegmentIndex)
        loginRegisterButton.setTitle(title, for: UIControl.State())
        
        // change height of inputContainerView, but how???
        //inputsContainerViewHeightAnchor?.constant = loginRegisterSegmentedControl.selectedSegmentIndex == 1 ? 15 : 10
        
        // change height of nameTextField
        nameTextFieldHeightAnchor?.isActive = false
        nameTextFieldHeightAnchor = nameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 1 ? 1/3 : 0)
        nameTextFieldHeightAnchor?.isActive = true
        
        emailTextFieldHeightAnchor?.isActive = false
        emailTextFieldHeightAnchor = emailTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 1 ? 1/3 : 1/2)
        emailTextFieldHeightAnchor?.isActive = true
        
        passwordTextFieldHeightAnchor?.isActive = false
        passwordTextFieldHeightAnchor = passwordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 1 ? 1/3 : 1/2)
        passwordTextFieldHeightAnchor?.isActive = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func addBannerViewToView() {
        
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(bannerView)
        
        self.bannerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        self.bannerView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
    }
    
    @objc func privacyPolicy() {
        self.navigationController?.customPush(viewController: PrivacyPolicy())
    }
}

*/

extension String {
    func removeWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
}

extension UIColor {
    convenience init (r: CGFloat, g: CGFloat, b: CGFloat){
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)        
    }
}
