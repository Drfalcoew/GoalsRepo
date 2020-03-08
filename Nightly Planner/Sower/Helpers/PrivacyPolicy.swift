//
//  PrivacyPolicy.swift
//  Nightly Planner
//
//  Created by Drew Foster on 7/18/19.
//  Copyright © 2019 Drew Foster. All rights reserved.
//

import UIKit

class PrivacyPolicy: UIViewController {
    let body1 : UITextView = {
        let view = UITextView()
        view.text = "Privacy Policy of QuestLine\n\nQuestLine operates the iOS App and www.drfalcoew.com website, which provides the SERVICE.\n\nThis page is used to inform website visitors regarding our policies with the collection, use, and disclosure of Personal Information if anyone decided to use our Service, the Drfalcoew website.\n\nIf you choose to use our Service, then you agree to the collection and use of information in relation with this policy. The Personal Information that we collect are used for providing and improving the Service. We will not use or share your information with anyone except as described in this Privacy Policy.\n\nInformation Collection and Use\n\nFor a better experience while using our Service, we may require you to provide us with certain personally identifiable information, including but not limited to your name, phone number, and postal address. The information that we collect will be used to contact or identify you.\n\nLog Data\n\nWe want to inform you that whenever you visit our Service, we collect information that your browser sends to us that is called Log Data. This Log Data may include information such as your computer’s Internet Protocol (\"IP\") address, browser version, pages of our Service that you visit, the time and date of your visit, the time spent on those pages, and other statistics.\n\nCookies\n\nCookies are files with small amount of data that is commonly used an anonymous unique identifier. These are sent to your browser from the website that you visit and are stored on your computer’s hard drive.\n\nOur website uses these \"cookies\" to collection information and to improve our Service. You have the option to either accept or refuse these cookies, and know when a cookie is being sent to your computer. If you choose to refuse our cookies, you may not be able to use some portions of our Service.\n\nService Providers\n\nWe may employ third-party companies and individuals due to the following reasons:\n\nTo facilitate our Service;\nTo provide the Service on our behalf;\nTo perform Service-related services; or\nTo assist us in analyzing how our Service is used.\n\nWe want to inform our Service users that these third parties have access to your Personal Information. The reason is to perform the tasks assigned to them on our behalf. However, they are obligated not to disclose or use the information for any other purpose.\n\nSecurity\n\nWe value your trust in providing us your Personal Information, thus we are striving to use commercially acceptable means of protecting it. But remember that no method of transmission over the internet, or method of electronic storage is 100% secure and reliable, and we cannot guarantee its absolute security.\n\nLinks to Other Sites\n\nOur Service may contain links to other sites. If you click on a third-party link, you will be directed to that site. Note that these external sites are not operated by us. Therefore, we strongly advise you to review the Privacy Policy of these websites. We have no control over, and assume no responsibility for the content, privacy policies, or practices of any third-party sites or services.\n\nContact Us\nIf you have any questions or suggestions about our Privacy Policy, do not hesitate to contact us."
        view.font = UIFont(name: "Helvetica Neue", size: 24)
        view.isUserInteractionEnabled = true
        view.backgroundColor = .clear
        view.textColor = UIColor(r: 75, g: 80, b: 120)
        
        view.isScrollEnabled = true
        //view.translatesAutoresizingMaskIntoConstraints = false
        //view.layer.masksToBounds = true
        return view
    }()
    
    
    
    override func viewDidLayoutSubviews()
    {
        //scrollView.delegate = self
        //body1.contentSize = CGSize(width: self.view.frame.size.width * 0.99, height: self.view.frame.height * 4.0) // set height according you
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("In VIEW DID LOAD")
        
        self.view.addSubview(body1)
        self.title = "Privacy Policy"
        
        setupConstraints()
    }
    
    func setupConstraints() {
        body1.frame = self.view.frame
    }
    
}
