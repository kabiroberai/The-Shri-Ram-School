//
//  LoginViewController.swift
//  The Shri Ram School
//
//  Created by Kabir Oberai on 21/08/15.
//  Copyright (c) 2015 The Shri Ram School. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UIWebViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var userField: UITextField!
    @IBOutlet weak var passField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBAction func performLogin(sender: UIButton) {
        if userField.text.isEmpty || passField.text.isEmpty {
            alertControllerMake("Error", message: "Please fill in your details")
            return
        }
        activityIndicator.startAnimating()
        sender.enabled = false
        portalLogin(userField.text, password: passField.text)
    }
    
    let shriPortalURL = NSURL(string: "http://shriportal.com/tsrs/Login.aspx")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userField.delegate = self
        passField.delegate = self
        webView.loadRequest(NSURLRequest(URL: shriPortalURL))
    }
    
    func portalLogin(username: String, password: String) {
        self.setElementValue("TxtName", value: username)
        self.setElementValue("TxtPassword", value: password)
        self.clickElement("Imgbtn_login")
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        delay(1) {
            if webView.request!.URL == NSURL(string: "http://shriportal.com/Homepage.aspx")! { //Logged in successfully
                self.loginButton.enabled = true
                self.activityIndicator.stopAnimating()
                //self.clickElement("img3")
                self.performSegueWithIdentifier("loginSegue", sender: self)
            } else if webView.request!.URL == self.shriPortalURL { //Either error or first load
                if !webView.stringByEvaluatingJavaScriptFromString("document.getElementById('lblmsg').innerText")!.isEmpty {
                    self.alertControllerMake("Error", message: "Incorrect username or password")
                    self.loginButton.enabled = true
                    self.activityIndicator.stopAnimating()
                } else { //First load
                    self.loginButton.enabled = true
                }
            }
        }
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError) {
        alertControllerMake("Error \(error.code)", message: error.localizedDescription)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == userField {
            passField.becomeFirstResponder()
        } else {
            passField.resignFirstResponder()
            if loginButton.enabled {
                performLogin(loginButton)
            }
        }
        return true
    }
    
    func setElementValue(element: String, value: String) {
        webView.stringByEvaluatingJavaScriptFromString("document.getElementById('\(element)').value='\(value)'")
    }
    
    func clickElement(element: String) {
        webView.stringByEvaluatingJavaScriptFromString("document.getElementById('\(element)').click()")
    }
    
    func alertControllerMake(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let classVC = segue.destinationViewController as? ClassViewController {
            classVC.webViewRequest = webView.request
        }
        // Pass the selected object to the new view controller.
    }
    
    
}
