//
//  DetailViewController.swift
//  News
//
//  Created by Saurabh D on 11/06/22.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    var path :String?
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let path = self.path else {return}
        
        let myURL = URL(string:path)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
}
