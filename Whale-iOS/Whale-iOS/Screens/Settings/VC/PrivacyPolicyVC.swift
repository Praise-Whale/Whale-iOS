//
//  PrivacyPolicyVC.swift
//  Whale-iOS
//
//  Created by Danna Lee on 2021/10/01.
//

import UIKit
import WebKit

class PrivacyPolicyVC: UIViewController {

    @IBOutlet var webView: WKWebView!
    
    enum WhatToShow {
        case privacyPolicy, termsOfService
    }
    var whatToShow: WhatToShow = .privacyPolicy
    
    var url = URL(string: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch whatToShow {
        case .privacyPolicy:
            url = URL(string: "https://www.notion.so/4ae478f551f249d097a6e46cffad6d07")
        case .termsOfService:
            url = URL(string: "https://www.notion.so/8ced90e384b1417ab6e24ce9c8436ab8")
        }
        
        let request = URLRequest(url: url!)
        
        webView.load(request)
    }
}
