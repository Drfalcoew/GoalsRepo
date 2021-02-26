//
//  ProfileViewController.swift
//  ZList
//
//  Created by Drew Foster on 1/29/17.
//  Copyright © 2017 Drfalcoew. All rights reserved.
//

import UIKit
import Firebase


class ProfileViewController: UIViewController, GADBannerViewDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var myPostedUsers: [myUsers] = []

    var email: String?
    var name: String?
    
    var dataId: [String] = []
 
    let viewLbl : UILabel = {
        let lbl = UILabel()
        lbl.text = "NO USERS TO DISPLAY"
        lbl.textColor = .white
        lbl.layer.masksToBounds = true
        lbl.alpha = 0
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.isHidden = false
        return lbl
    }()
    
    let tableView : UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.layer.masksToBounds = true
        tv.layer.cornerRadius = 5
        //tv.isUserInteractionEnabled = false
        tv.alpha = 0
        tv.backgroundColor = UIColor.init(white: 0.7, alpha: 0.7)
        return tv
    }()
    
    let saveButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("save", for: UIControlState.normal)
        btn.setTitleColor(UIColor.gray, for: UIControlState.normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.masksToBounds = true
        btn.addTarget(self, action: #selector(confirmChange), for: .touchUpInside)
        return btn
    }()
   
   
    var userName: UILabel = {
        let lbl = UILabel()
        lbl.text = "User"
        lbl.alpha = 0
        lbl.textColor = .white
        lbl.font = UIFont.boldSystemFont(ofSize: 26)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        return lbl
    }()
    
    let ref = FIRDatabase.database().reference(withPath: "users")
    let zRef = FIRDatabase.database().reference(withPath: "ZListUsers")

    let inputsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.alpha = 0
        view.layer.masksToBounds = true
        return view
    }()
    
    let editorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.alpha = 0
        view.layer.masksToBounds = true
        return view
    }()
    
    
    let back : UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.masksToBounds = true
        btn.alpha = 0
        btn.tintColor = .white
        btn.addTarget(self, action: #selector(backToMain), for: .touchUpInside)
        btn.setTitle("Back", for: .normal)
        return btn
    }()

    
    // Email
    var emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.isUserInteractionEnabled = false
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    
    var emailSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    
    // Password
    var passwordTextField: UITextField = {
        let ltf = UITextField()
        ltf.isHidden = true
        ltf.placeholder = "Old Password"
        ltf.isUserInteractionEnabled = false
        ltf.isSecureTextEntry = true
        //ltf.backgroundColor = UIColor.init(white: 1.0, alpha: 0.6)
        ltf.layer.cornerRadius = 5
        ltf.translatesAutoresizingMaskIntoConstraints = false
        return ltf
    }()
    
    
    let passwordSeparatorView: UIView = {
        let view = UIView()
        view.isHidden = true
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    
    // New Password
    var newPasswordTextField: UITextField = {
        let ltf = UITextField()
        ltf.isHidden = true
        ltf.placeholder = "New Password"
        ltf.layer.cornerRadius = 5
        ltf.isUserInteractionEnabled = false
        ltf.isSecureTextEntry = true
        //ltf.backgroundColor = UIColor.init(white: 1.0, alpha: 0.6)
        ltf.translatesAutoresizingMaskIntoConstraints = false
        return ltf
    }()
    
    
    let newPasswordSeparatorView: UIView = {
        let view = UIView()
        view.isHidden = true
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // Repeat New Password
    var repeatNewPasswordTextField: UITextField = {
        let ltf = UITextField()
        ltf.isHidden = true
        ltf.placeholder = "Repeat Password"
        ltf.layer.cornerRadius = 5
        ltf.isUserInteractionEnabled = false
        ltf.isSecureTextEntry = true
        //ltf.backgroundColor = UIColor.init(white: 1.0, alpha: 0.6)
        ltf.translatesAutoresizingMaskIntoConstraints = false
        return ltf
    }()
    
    let changePasswordView: UIButton = {
        let button = UIButton()
        button.setTitle("edit", for: UIControlState.normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.white
        button.layer.cornerRadius = 5
        button.setTitleColor(UIColor(r: 187, g: 100, b: 0), for: UIControlState.normal)
        button.addTarget(self, action: #selector(changePassword), for: .touchUpInside)
        return button
    }()

    
    let repeatNewPasswordSeparatorView: UIView = {
        let view = UIView()
        view.isHidden = true
        view.layer.masksToBounds = true
        view.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    let topView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.alpha = 0
        view.layer.masksToBounds = true
        return view
    }()
    
    let backgroundView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "background")
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.5, animations: {
            self.topView.alpha = 1.0
            self.userName.alpha = 1.0
            self.inputsContainerView.alpha = 1.0
            self.back.alpha = 1.0
            self.tableView.alpha = 1.0
            self.saveButton.alpha = 1.0
            self.viewLbl.alpha = 1.0
        }, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let uid = FIRAuth.auth()?.currentUser?.uid
        
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")

        
        saveButton.isEnabled = false
        saveButton.tintColor = UIColor(r: 187, g: 110, b: 0)
        
        view.addSubview(backgroundView)
        view.addSubview(topView)
        view.addSubview(editorView)
        view.addSubview(inputsContainerView)
        view.addSubview(userName)
        view.addSubview(back)
        view.addSubview(viewLbl)
        view.addSubview(tableView)
        
  
        ref.child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject] {
                print("Hello, \(dictionary["email"] as? String)!")
                print("Hello, \(dictionary["name"] as? String)!")
                self.userName.text = dictionary["name"] as? String
                self.emailTextField.text = dictionary["email"] as! String?
                self.email = dictionary["email"] as! String
                self.name = dictionary["name"] as! String
                
                
                self.zRef.observe(.value, with: { (snapshot) in
                    var post: [myUsers] = []
                    for item in snapshot.children {
                        let userTest = myUsers(snapshot: item as! FIRDataSnapshot)
                        if userTest.addedBy == self.email?.lowercased() {
                            //print("\(userTest.addedBy) == \(self.email?.lowercased())")
                            post.append(userTest)
                            self.dataId.append(userTest.key!)
                            self.myPostedUsers = post
                            self.tableView.reloadData()
                        } else {
                            //print("\(userTest.addedBy) != \(self.email?.lowercased())")
                        }
                    }
                    
                }) { (error) in
                    print("Ran into the error: \(error.localizedDescription))")
                }
                
            }
        }, withCancel: nil)
        
        
        
 
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        


        
        let request = GADRequest()
        request.testDevices = [kGADSimulatorID]
        
        
        let bannerView = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait)
        
        bannerView.adUnitID = "ca-app-pub-8752347849222491/9299846161"

        
        bannerView.rootViewController = self
        self.topView.addSubview(bannerView)
        bannerView.load(GADRequest())
        
        bannerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
     
        setupConstraints()
 
    }

  
    
    
    
    func displayAlert(_ userMessage: String){
        
        let myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        myAlert.addAction(okAction)
        self.present(myAlert, animated: true, completion: nil)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    
    
    
    func changePassword(_ sender: UIButton!) {
        
        passwordTextField.text = ""
        repeatNewPasswordTextField.text = ""
        newPasswordTextField.text = ""
        saveButton.isEnabled = true
        //saveButton.tintColor = UIColor.white
        
        
        if (newPasswordTextField.isHidden == true){
            changePasswordView.backgroundColor = UIColor.init(white: 1.0, alpha: 0.6)
            saveButton.isEnabled = true
            saveButton.setTitleColor(UIColor.blue, for: UIControlState.normal)

            passwordSeparatorView.isHidden = false
            newPasswordSeparatorView.isHidden = false
            repeatNewPasswordSeparatorView.isHidden = false
        
            self.passwordTextField.isHidden = false
            self.repeatNewPasswordTextField.isHidden = false
            self.newPasswordTextField.isHidden = false
            
            self.passwordSeparatorView.isHidden = false
            self.repeatNewPasswordSeparatorView.isHidden = false
            self.newPasswordSeparatorView.isHidden = false
  
            self.passwordTextField.isUserInteractionEnabled = true
            self.passwordTextField.isUserInteractionEnabled = true
            self.newPasswordTextField.isUserInteractionEnabled = true
            self.repeatNewPasswordTextField.isUserInteractionEnabled = true
            
            UIView.animate(withDuration: 0.5, animations: {
                self.editorView.alpha = 1
            }, completion: nil)
        }
            
        else if (newPasswordTextField.isHidden == false){
            
            
            changePasswordView.backgroundColor = UIColor.init(white: 1.0, alpha: 1.0)
            saveButton.isEnabled = false
            saveButton.setTitleColor(UIColor.gray, for: UIControlState.normal)

            self.passwordTextField.isHidden = true
            self.repeatNewPasswordTextField.isHidden = true
            self.newPasswordTextField.isHidden = true
            
            self.passwordSeparatorView.isHidden = true
            self.repeatNewPasswordSeparatorView.isHidden = true
            self.newPasswordSeparatorView.isHidden = true
            
            
            passwordSeparatorView.isHidden = true
            newPasswordSeparatorView.isHidden = true
        
        
        
            self.passwordTextField.isUserInteractionEnabled = false
            self.passwordTextField.isUserInteractionEnabled = false
            self.newPasswordTextField.isUserInteractionEnabled = false
            self.repeatNewPasswordTextField.isUserInteractionEnabled = false
        
            UIView.animate(withDuration: 0.5, animations: {
                self.editorView.alpha = 0
            }, completion: nil)
                
            }
        
    }

    
    
    func confirmChange() {

        let user = FIRAuth.auth()?.currentUser
        
        let credential = FIREmailPasswordAuthProvider.credential(withEmail: emailTextField.text!, password: passwordTextField.text!)
        
        
        if newPasswordTextField.text?.isEmpty == true || passwordTextField.text?.isEmpty == true || repeatNewPasswordTextField.text?.isEmpty == true {
            displayAlert("One or more fields are empty")
            return
        }
        else {
        user?.reauthenticate(with: credential, completion: { (error) in
            if error != nil{
                self.displayAlert("Old password does not match")
            }else{
                //change to new password
                
                
                if self.newPasswordTextField.text != self.repeatNewPasswordTextField.text {
                    self.displayAlert("New passwords do not match")
                    return
                }
                    
                else {
                    
                    user?.updatePassword(self.repeatNewPasswordTextField.text!, completion: { (error) in
                        if error != nil {
                            self.displayAlert("An error occurred")
                            return
                        }
                        else {
                            self.passwordTextField.isHidden = true
                            self.repeatNewPasswordTextField.isHidden = true
                            self.newPasswordTextField.isHidden = true
                            
                            self.passwordSeparatorView.isHidden = true
                            self.repeatNewPasswordSeparatorView.isHidden = true
                            self.newPasswordSeparatorView.isHidden = true
                            
                            
                            
                            
                            self.passwordTextField.isUserInteractionEnabled = false
                            self.passwordTextField.isUserInteractionEnabled = false
                            self.newPasswordTextField.isUserInteractionEnabled = false
                            self.repeatNewPasswordTextField.isUserInteractionEnabled = false
                            
                            self.displayAlert("Successfully Changed Password.")
                            }
                        })
                    
                    
                    }
                
                }
            })
   
        }
    
    }
 
    func backToMain() {
        UIView.animate(withDuration: 0.5, animations: {
            self.inputsContainerView.alpha = 0
            self.userName.alpha = 0
            self.topView.alpha = 0
            self.back.alpha = 0
            self.saveButton.alpha = 0
            self.tableView.alpha = 0
            self.viewLbl.alpha = 0
        }) { (true) in
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    
    func setupConstraints() {
   
        backgroundView.heightAnchor.constraint(equalToConstant: view.frame.height).isActive = true
        backgroundView.widthAnchor.constraint(equalToConstant: (view.frame.height * 0.5625))
        backgroundView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        backgroundView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        
        back.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        back.topAnchor.constraint(equalTo: view.topAnchor, constant: UIApplication.shared.statusBarFrame.height + ((UIApplication.shared.statusBarFrame.height)/2)).isActive = true
        
        userName.topAnchor.constraint(equalTo: back.bottomAnchor, constant: 25).isActive = true
        userName.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    
        inputsContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputsContainerView.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: 10).isActive = true
        inputsContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        inputsContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/9).isActive = true
        
        editorView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        editorView.topAnchor.constraint(equalTo: inputsContainerView.topAnchor, constant: 0).isActive = true
        editorView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        editorView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/3).isActive = true
        
        inputsContainerViewHeightAnchor = editorView.heightAnchor.constraint(equalToConstant: view.frame.height / 2)
        inputsContainerViewHeightAnchor?.isActive = true
        
        
        
        inputsContainerView.addSubview(emailTextField)
        editorView.addSubview(emailSeparatorView)
        
        editorView.addSubview(passwordTextField)
        editorView.addSubview(passwordSeparatorView)
        
        editorView.addSubview(newPasswordTextField)
        editorView.addSubview(newPasswordSeparatorView)
        
        editorView.addSubview(repeatNewPasswordTextField)
        editorView.addSubview(repeatNewPasswordSeparatorView)
        
        inputsContainerView.addSubview(changePasswordView)
        inputsContainerView.addSubview(saveButton)
        
      

        emailTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        emailTextField.topAnchor.constraint(equalTo: inputsContainerView.topAnchor).isActive = true
        
        emailTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor, multiplier: 1/2).isActive = true
        emailTextFieldHeightAnchor = emailTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1)
        emailTextFieldHeightAnchor?.isActive = true
        
        
        // INSIDE PROFILE VIEW
        changePasswordView.centerYAnchor.constraint(equalTo: inputsContainerView.centerYAnchor, constant: 0).isActive = true
        changePasswordView.leftAnchor.constraint(equalTo: emailTextField.rightAnchor, constant: 10).isActive = true
        changePasswordView.bottomAnchor.constraint(equalTo: emailSeparatorView.topAnchor, constant: -8).isActive = true
        
        saveButton.centerYAnchor.constraint(equalTo: inputsContainerView.centerYAnchor, constant: 0).isActive = true
        saveButton.rightAnchor.constraint(equalTo: inputsContainerView.rightAnchor, constant: -10).isActive = true
        
        
        emailSeparatorView.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        emailSeparatorView.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        emailSeparatorView.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        emailSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        
        
        
        passwordTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        passwordTextField.rightAnchor.constraint(equalTo: inputsContainerView.rightAnchor, constant: -12).isActive = true
        //passwordTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        passwordTextFieldHeightAnchor = passwordTextField.heightAnchor.constraint(equalToConstant: view.frame.height / 9 * 2 / 3)
        //passwordTextFieldHeightAnchor = passwordTextField.heightAnchor.constraint(equalToConstant: 35)
        passwordTextFieldHeightAnchor?.isActive = true
        
        
        // INSIDE PROFILE VIEW
      
        
        passwordSeparatorView.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        passwordSeparatorView.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor).isActive = true
        passwordSeparatorView.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        passwordSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        //need x, y, width, height constraints
        
        
        
        newPasswordTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        newPasswordTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 0).isActive = true
        
        //newPasswordTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        newPasswordTextField.rightAnchor.constraint(equalTo: inputsContainerView.rightAnchor, constant: -12)
        newPasswordTextFieldHeightAnchor = newPasswordTextField.heightAnchor.constraint(equalToConstant: view.frame.height / 9 * 2 / 3)
        //newPasswordTextFieldHeightAnchor = newPasswordTextField.heightAnchor.constraint(equalToConstant: 35)
        
        newPasswordTextFieldHeightAnchor?.isActive = true
        
        //need x, y, width, height constraints
        newPasswordSeparatorView.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        newPasswordSeparatorView.topAnchor.constraint(equalTo: newPasswordTextField.bottomAnchor).isActive = true
        newPasswordSeparatorView.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        newPasswordSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
       
        // INSIDE PROFILE VIEW
        
        
        //need x, y, width, height constraints
        repeatNewPasswordTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        repeatNewPasswordTextField.topAnchor.constraint(equalTo: newPasswordTextField.bottomAnchor, constant: 0).isActive = true
        
        //repeatNewPasswordTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        repeatNewPasswordTextFieldHeightAnchor = repeatNewPasswordTextField.heightAnchor.constraint(equalToConstant: view.frame.height / 9 * 2 / 3)
        repeatNewPasswordTextField.rightAnchor.constraint(equalTo: inputsContainerView.rightAnchor, constant: -12)
        //repeatNewPasswordTextFieldHeightAnchor = repeatNewPasswordTextField.heightAnchor.constraint(equalToConstant: 35)
        repeatNewPasswordTextFieldHeightAnchor?.isActive = true
        
        // container for ad
        topView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        topView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        topView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        if (view.frame.height <= 400){
            topViewHeightAnchor = topView.heightAnchor.constraint(equalToConstant: 32)
            print("<= 400")
        } else if (view.frame.height > 400 && view.frame.height <= 720) {
            topViewHeightAnchor = topView.heightAnchor.constraint(equalToConstant: 50)
            print(">400&&<=720")
        } else if (view.frame.height > 720){
            topViewHeightAnchor = topView.heightAnchor.constraint(equalToConstant: 90)
            print(">720")
        }
        topViewHeightAnchor?.isActive = true
        
        
        tableView.topAnchor.constraint(equalTo: editorView.bottomAnchor, constant: 25).isActive = true
        tableView.bottomAnchor.constraint(equalTo: topView.topAnchor, constant: -25).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12).isActive = true
        //tableView.frame = scrollView.frame
        
        viewLbl.centerXAnchor.constraint(equalTo: tableView.centerXAnchor).isActive = true
        viewLbl.centerYAnchor.constraint(equalTo: tableView.centerYAnchor).isActive = true
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected row: \(indexPath.row)")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height / 2.8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellId") else {
            fatalError("no cell")
        }
        print(myPostedUsers.count)

        let Users = myPostedUsers[indexPath.row]
        
        if let x = Users.name, let y = Users.lastName, let z = Users.zipCode {
            cell.textLabel?.text = (x + " " + y)
            cell.detailTextLabel?.text = ("ZipCode: \(z)")
            return cell
        }
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if myPostedUsers.count < 1 {
            viewLbl.isHidden = false
            return 0
        }
        else {
            viewLbl.isHidden = true
            return myPostedUsers.count
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if myPostedUsers.count < 1 {
            return false
        } else {
            return true
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //remove ref data
            zRef.child(dataId[indexPath.row]).removeValue()
            myPostedUsers.remove(at: indexPath.row)
            dataId.remove(at: indexPath.row)
            
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    

    var repeatNewPasswordTextFieldHeightAnchor: NSLayoutConstraint?
    var newPasswordTextFieldHeightAnchor: NSLayoutConstraint?
    var passwordTextFieldHeightAnchor: NSLayoutConstraint?
    var emailTextFieldHeightAnchor: NSLayoutConstraint?
    var inputsContainerViewHeightAnchor: NSLayoutConstraint?
    var topViewHeightAnchor: NSLayoutConstraint?
    var userNameHeightAnchor: NSLayoutConstraint?
    
    
    
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
        
    }
}
