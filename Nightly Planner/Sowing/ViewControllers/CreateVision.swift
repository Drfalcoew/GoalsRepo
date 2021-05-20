//
//  CreateVision.swift
//  Sowing
//
//  Created by Drew Foster on 5/4/21.
//  Copyright © 2021 Drew Foster. All rights reserved.
//

import Foundation
import UIKit

class CreateVision : UIViewController {
    
    var textView : UITextView = {
        let view = UITextView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        return view
    }()
    
    let addButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Submit", for: .normal)
        btn.backgroundColor = UIColor(r: 75, g: 80, b: 120)
        btn.setTitleColor(UIColor.white, for: UIControl.State())
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        btn.layer.cornerRadius = 2
        btn.addTarget(self, action: #selector(addVision), for: .touchUpInside)
        return btn
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(addButton)
        self.view.addSubview(textView)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            textView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            textView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            textView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8),
            textView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.7),
            
            addButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0),
            addButton.topAnchor.constraint(equalTo: self.textView.bottomAnchor, constant: 20),
            addButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.3),
            addButton.heightAnchor.constraint(equalTo: self.addButton.widthAnchor, multiplier: 1/2)
        ])
    }
    
    @objc func addVision() {
        
    }
    
    
}
