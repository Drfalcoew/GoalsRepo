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
        view.text = "Welcome to Questline!"
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
        view.text = "First of all, thank you for downloading!  With Questline we focus on improving the lives of our users by optimizing their productivity by organizing goals to allow users to complete their goals more simply and clearly, while fighting laziness and procrastination.  The app is broken down into 4 categories as of version 1.0: Daily, Focus, Inspiration, Profile."
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
    
    let header2 : UILabel = {
        let view = UILabel()
        view.text = "Daily"
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
    
    let body2 : UITextView = {
        let view = UITextView()
        view.text = "The main page of the app is the Daily page, where you will find your daily goals and how to create them.  These should be goals you should be able to complete within one day.  After some research, I have found that the daily recommended amount of goals is between three and five, which is why I thought four would be an adequate number.  The reason it is not more is because your focus, which is a finite resource, would be split even further.  Therefore having even less goals than four would increase the efficiency of the completion speed and quality.\n     To create a goal, there are only two steps.  Once you click the add button, you write in the title, which can be however long.  The more descriptive you are, the more clear and achievable the completion of the goal will be.  The second step is a collection of your projects that you can use as a parent category for your daily goals.  If this view is empty, that means you have no long term goals/projects created.  The reason for this is because if your daily goals are not aimed at an ultimate, long-term goal, with some exceptions, then you might find yourself drifting aimlessly.  Then that's it!  There's a timer on top of each goal to keep track of how long it takes you to complete them.  If you click the goal, it will give you an option to either complete or delete them."
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
    
    let header3 : UILabel = {
        let view = UILabel()
        view.text = "Focus"
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
    
    let body3 : UITextView = {
        let view = UITextView()
        view.text = "The Projects tab is the reason why we are here.  The big goals and dreams in our lives that one day we wish to achieve.  The Daily page consists of the steps you must take to reach these.  Start by pressing the add button, then fill out the title, a practical date, and an icon that represents it.  This is the icon that you will find in the second step to creating your short term goals in the Daily page."
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
    
    let header5 : UILabel = {
        let view = UILabel()
        view.text = "Profile"
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
    
    let body5 : UITextView = {
        let view = UITextView()
        view.text = "Here you can find the statistics for your account, and more saved data including your completed long-term goals."
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
        view.text = "Version 2.0"
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
        scrollView.contentSize = CGSize(width:self.view.frame.size.width * 0.9, height: self.view.frame.height * 6.1) // set height according you
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
    }
    
    func setupViews() {
        
        self.view.addSubview(scrollView)
        scrollView.addSubview(header1)
        scrollView.addSubview(body1)
        scrollView.addSubview(header2)
        scrollView.addSubview(body2)
        scrollView.addSubview(header3)
        scrollView.addSubview(body3)
        scrollView.addSubview(header5)
        scrollView.addSubview(body5)
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
        
        header2.topAnchor.constraint(equalTo: body1.bottomAnchor, constant: 10).isActive = true
        header2.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 5).isActive = true
        header2.heightAnchor.constraint(equalToConstant: 65).isActive = true
        header2.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.96).isActive = true
        
        body2.topAnchor.constraint(equalTo: header2.bottomAnchor, constant: 5).isActive = true
        body2.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 5).isActive = true
        body2.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.96).isActive = true
        
        header3.topAnchor.constraint(equalTo: body2.bottomAnchor, constant: 10).isActive = true
        header3.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 5).isActive = true
        header3.heightAnchor.constraint(equalToConstant: 65).isActive = true
        header3.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.96).isActive = true
        
        body3.topAnchor.constraint(equalTo: header3.bottomAnchor, constant: 5).isActive = true
        body3.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 5).isActive = true
        body3.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.96).isActive = true
        
        header5.topAnchor.constraint(equalTo: body3.bottomAnchor, constant: 10).isActive = true
        header5.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 5).isActive = true
        header5.heightAnchor.constraint(equalToConstant: 65).isActive = true
        header5.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.96).isActive = true
        
        body5.topAnchor.constraint(equalTo: header5.bottomAnchor, constant: 5).isActive = true
        body5.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 5).isActive = true
        body5.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.96).isActive = true
        
        header6.topAnchor.constraint(equalTo: body5.bottomAnchor, constant: 10).isActive = true
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
