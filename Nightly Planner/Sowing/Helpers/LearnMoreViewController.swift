//
//  LearnMoreViewController.swift
//  Nightly Planner
//
//  Created by Drew Foster on 6/10/19.
//  Copyright © 2019 Drew Foster. All rights reserved.
//

import Foundation
import UIKit

class LearnMoreViewController: UIViewController {
    
    let scrollView : UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
//        view.layer.masksToBounds = true
        view.backgroundColor = .clear
        view.isScrollEnabled = true
        view.layer.cornerRadius = 20
        view.backgroundColor = .clear//UIColor(r: 221, g: 221, b: 221)
        view.alpha = 0.7
        return view
    }()
    
    let header1 : UILabel = {
        let view = UILabel()
        view.text = "Welcome to Sower!"
        view.textColor = UIColor(r: 75, g: 80, b: 120)
        
        view.adjustsFontSizeToFitWidth = true
        view.numberOfLines = 2
        view.lineBreakMode = .byTruncatingTail
        view.minimumScaleFactor = 0.2
        view.font = UIFont(name: "HelveticaNeue-Bold", size: 36)
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        return view
    }()
    
    let body1 : UITextView = {
        let view = UITextView()
        view.text = "Thank you for downloading! We focus on improving the lives of our users by optimizing their productivity by organizing their goals to allow users to complete them more simply and clearly while fighting laziness and procrastination, because ultimately procrastination leads to regret. The app has two types of goals: routine (daily reoccuring tasks), and one time tasks. To keep yourself on track, carefully craft a detailed vision, and write it down in the vision tab of the app."
        view.font = UIFont(name: "Helvetica Neue", size: 24)
        view.isUserInteractionEnabled = false
        view.backgroundColor = .clear
        view.sizeToFit()
        view.textColor = UIColor(r: 75, g: 80, b: 120)
        view.isScrollEnabled = false
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        return view
    }()
    
    let header6 : UILabel = {
        let view = UILabel()
        view.text = "Version 3.0"
        view.textColor = UIColor(r: 75, g: 80, b: 120)
        
        view.adjustsFontSizeToFitWidth = true
        view.numberOfLines = 1
        view.lineBreakMode = .byTruncatingTail
        view.minimumScaleFactor = 0.5
        view.font = UIFont(name: "HelveticaNeue-Bold", size: 36)
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        return view
    }()
    
    let body6 : UITextView = {
        let view = UITextView()
        view.text = "Coming Soon!"
        view.font = UIFont(name: "Helvetica Neue", size: 24)
        view.isUserInteractionEnabled = false
        view.backgroundColor = .clear
        view.sizeToFit()
        view.textColor = UIColor(r: 75, g: 80, b: 120)
        
        view.isScrollEnabled = false
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        return view
    }()
    
    override func viewDidLayoutSubviews()
    {
        //scrollView.delegate = self
        scrollView.contentSize = CGSize(width:self.view.frame.size.width * 0.9, height: self.view.frame.height * 1.1) // set height accordingly
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
        
        setupNavigation()
        setupViews()
        setupConstraints()
    }
    
    func setupNavigation() {
        self.title = "Learn More"
        
        navigationController?.navigationBar.tintColor = UIColor(r: 75, g: 80, b: 120)

        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue): UIColor(r: 75, g: 80, b: 120)]
    }
    
    func setupViews() {
        
        self.view.addSubview(scrollView)
        scrollView.addSubview(header1)
        scrollView.addSubview(body1)
        scrollView.addSubview(header6)
        scrollView.addSubview(body6)
    }
    
    func setupConstraints() {
        scrollView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -50).isActive = true
        scrollView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        scrollView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: (navigationController?.navigationBar.frame.height ?? 60) + 5).isActive = true
        
        header1.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 5).isActive = true
        header1.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 5).isActive = true
        header1.heightAnchor.constraint(equalToConstant: 65).isActive = true
        header1.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.96).isActive = true
        
        body1.topAnchor.constraint(equalTo: header1.bottomAnchor, constant: 5).isActive = true
        body1.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 5).isActive = true
        body1.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.96).isActive = true
        
        
        header6.topAnchor.constraint(equalTo: body1.bottomAnchor, constant: 10).isActive = true
        header6.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 5).isActive = true
        header6.heightAnchor.constraint(equalToConstant: 65).isActive = true
        header6.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.96).isActive = true
        
        body6.topAnchor.constraint(equalTo: header6.bottomAnchor, constant: 5).isActive = true
        body6.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 5).isActive = true
        body6.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.96).isActive = true
    
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
}
