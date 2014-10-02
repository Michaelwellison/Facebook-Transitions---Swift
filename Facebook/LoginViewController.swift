//
//  LoginViewController.swift
//  Facebook
//
//  Created by Michael Ellison on 9/22/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    @IBOutlet weak var loginView: UIView!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
        logInButton.enabled = false
        
        activityIndicator.hidden = true
    }
    
    
    func checkPasswordAndEmail() {
        
        if emailTextField.text != "" && passwordTextField.text != "" {
            logInButton.enabled = true
        }
        else {
            logInButton.enabled = false
        }
        
    }
    
    func checkLogin(){
        var emailFieldInput = String(emailTextField.text)
        var passwordFieldInput = String(passwordTextField.text)
        
        if emailFieldInput == "m@me.com" && passwordFieldInput == "p" {
            
            var signingInView = UIAlertController(title: "Signing in...", message: "", preferredStyle: UIAlertControllerStyle.Alert)
            self.presentViewController(signingInView, animated: true, completion: nil)
            
            delay(2.0, closure: {
                self.dismissViewControllerAnimated(true, completion: nil)
                self.performSegueWithIdentifier("loginIn", sender: self)
            })
            
        } else {
            
            var errorView = UIAlertController(title: "Incorrect Password", message: "The password or username you entered is incorrect. Please try again.", preferredStyle: UIAlertControllerStyle.Alert)
            errorView.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(errorView, animated: true, completion: nil)
        }
    }
    
    
    // MARK: NSNotification
    
    func keyboardWillShow(notification: NSNotification!) {
        
        UIView.animateWithDuration(1.0, animations: {
            self.loginView.frame = CGRectMake(7, 80, self.loginView.frame.width, self.loginView.frame.height)
        })
    }
    
    func keyboardWillHide(notification: NSNotification!) {
        
        UIView.animateWithDuration(1.0, animations: {
            self.loginView.frame = CGRectMake(7, 204, self.loginView.frame.width, self.loginView.frame.height)
        })
        
     // MARK: Text Field Delegate
        
        func textField(textField: UITextField, shouldChangeCharactersInRange: NSRange, replacementString: String) {
           
            println(" did this work")
        }
        
    }
    @IBAction func onTapLoginButton(sender: AnyObject) {
        
        activityIndicator.startAnimating()
        delay(2.0, closure: {
            self.checkLogin()
            self.activityIndicator.stopAnimating()
        })
        
    }
    
    @IBAction func endEditing(sender: UITapGestureRecognizer) {
        
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    @IBAction func onEditingChanged(sender: UITextField) {
        checkPasswordAndEmail()
        
        
    }
    

    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }

}
