//
//  EditProfileImageView.swift
//  Sowing
//
//  Created by Drew Foster on 6/11/21.
//  Copyright © 2021 Drew Foster. All rights reserved.
//

import Foundation
import UIKit

class EditProfileCells : UITableViewCell {
    
    let nameLabel : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.2
        lbl.font = UIFont(name: "Helvetica Neue", size: 18)
        return lbl
    }()
    
    
    
    let textBox : UITextField = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .center
        view.layer.masksToBounds = true
        view.clearsOnInsertion = true
        view.textColor = .gray
        view.borderStyle = .bezel
        view.backgroundColor = .lightGray
        view.isUserInteractionEnabled = true
        view.allowsEditingTextAttributes = true
        view.layer.zPosition = 5
        return view
    }()
    

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        self.addSubview(nameLabel)
        self.addSubview(textBox)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: self.frame.width * 0.15),
            nameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            nameLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4),
            nameLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.8),
            
            textBox.rightAnchor.constraint(equalTo: self.rightAnchor, constant: self.frame.width * -0.15),
            textBox.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            textBox.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4),
            textBox.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.8),
            
        ])
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
}

class ImageViewSubclass : UICollectionViewCell {

    
    let profileImage : UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.masksToBounds = true
        return img
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        self.addSubview(profileImage)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            self.profileImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.profileImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.profileImage.widthAnchor.constraint(equalTo: self.widthAnchor),
            self.profileImage.heightAnchor.constraint(equalTo: self.heightAnchor)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
}



class EditProfileImageView : UIViewController {
  
    
    var collectionView : UICollectionView!

    let titleLabel : GreetingViewSubclass = {
        let view = GreetingViewSubclass()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.titleLabel.text = "Edit Profile"
        return view
    }()
    
    /*var tableView : UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(r: 40, g: 43, b: 53)
        return view
    }()*/
    
    var label : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.text = "Username"
        lbl.minimumScaleFactor = 0.2
        lbl.adjustsFontSizeToFitWidth = true
        lbl.numberOfLines = 1
        lbl.font = UIFont(name: "Helvetica Neue", size: 20)
        
        return lbl
    }()
    
    var textBox : UITextField = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .center
        view.layer.masksToBounds = true
        view.clearsOnInsertion = true
        view.textColor = UIColor(r: 150, g: 150, b: 150)
        view.borderStyle = .bezel
        view.isUserInteractionEnabled = true
        view.allowsEditingTextAttributes = true
        view.layer.zPosition = 5
        return view
    }()
    
    let nameLabel_2 : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.2
        lbl.text = "Date Joined"
        lbl.font = UIFont(name: "Helvetica Neue", size: 18)
        return lbl
    }()
    
    let dateValue : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.2
        lbl.textColor = UIColor(r: 150, g: 150, b: 150)
        lbl.textAlignment = .center
        lbl.font = UIFont(name: "Helvetica Neue", size: 18)
        return lbl
    }()
    
    let cellId = "cellId"
    
    override func viewWillLayoutSubviews() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setupTableView()
        setupAttributes()
        setupViews()
        setupCollectionView()
        setupNavigation()
        setupConstraints()
    }
    
    func setupAttributes() {
        textBox.text = UserDefaults.standard.string(forKey: "Username") ?? "Username"
        dateValue.text = UserDefaults.standard.string(forKey: "dateJoined")
    }
    
    func setupNavigation() {
        
        let save = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(handleSave))
        save.tintColor = UIColor(r: 40, g: 43, b: 53)
        save.isEnabled = true
        self.navigationItem.rightBarButtonItem = save
        
    }

    @objc func handleSave() {
        UserDefaults.standard.setValue(textBox.text, forKey: "Username")
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "setupVariables"), object: nil)
        self.navigationController?.customPop()
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0),
            titleLabel.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1/8.5),
            titleLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8),
            titleLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: (navigationController?.navigationBar.frame.height ?? 60) + self.view.frame.height * -0.035),
            
//            tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0),
//            tableView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: 0),
//            tableView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.8),
            
            label.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 10),
            label.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: self.view.frame.width * 0.1),
            label.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.4),
            label.heightAnchor.constraint(equalToConstant: 60),
            
            textBox.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: self.view.frame.width * -0.15),
            textBox.centerYAnchor.constraint(equalTo: self.label.centerYAnchor, constant: 0),
            textBox.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.4),
            textBox.heightAnchor.constraint(equalToConstant: 45),
            
            
            nameLabel_2.centerXAnchor.constraint(equalTo: self.label.centerXAnchor, constant: 0),
            nameLabel_2.widthAnchor.constraint(equalTo: self.label.widthAnchor, multiplier: 1),
            nameLabel_2.heightAnchor.constraint(equalTo: self.label.heightAnchor, multiplier: 1),
            nameLabel_2.topAnchor.constraint(equalTo: self.label.bottomAnchor, constant: 15),
            
            dateValue.centerYAnchor.constraint(equalTo: self.nameLabel_2.centerYAnchor, constant: 0),
            dateValue.centerXAnchor.constraint(equalTo: self.textBox.centerXAnchor, constant: 0),
            dateValue.widthAnchor.constraint(equalTo: self.nameLabel_2.widthAnchor, multiplier: 1),
            dateValue.heightAnchor.constraint(equalTo: self.nameLabel_2.heightAnchor, multiplier: 1)

            
        ])
    }
    
    func setupCollectionView() {
       /* let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (self.view.frame.width / 4), height: (self.view.frame.width / 4))
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.collectionViewLayout = layout
        collectionView.isScrollEnabled = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.layer.masksToBounds = true
        collectionView.backgroundColor = UIColor(r: 221, g: 221, b: 221)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.allowsSelection = true
        collectionView.layer.zPosition = 2
        
        collectionView.register(ImageViewSubclass.self, forCellWithReuseIdentifier: cellId)*/
    }

   /* func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height / 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: cellId) as! EditProfileCells

        switch indexPath.row {
        case 0:
            cell.nameLabel.text = "Username"
            cell.textBox.text = "Drfalcoew"
            break
        case 1:
            cell.nameLabel.text = "Email"
            
            break
        case 2:
            break
        default: break
        }
        
        return cell
    }*/
    
    
    
    func setupViews() {
        self.view.backgroundColor = .white
        self.view.addSubview(titleLabel)
        self.view.addSubview(label)
        self.view.addSubview(textBox)
        self.view.addSubview(nameLabel_2)
        self.view.addSubview(dateValue)
    }
    
    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ImageViewSubclass
//        cell.profileImage.image = UIImage(named: "profile_\(indexPath.row)")
//        cell.layer.cornerRadius = self.view.frame.width / 8
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//
//    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 5
//    }


}
