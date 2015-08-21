//
//  ClassViewController.swift
//  The Shri Ram School
//
//  Created by Kabir Oberai on 21/08/15.
//  Copyright (c) 2015 The Shri Ram School. All rights reserved.
//

import UIKit

class ClassViewController: UIViewController {
    
    var webViewRequest: NSURLRequest!
    
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.loadRequest(webViewRequest)
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
