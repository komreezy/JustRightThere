//
//  SignupViewController.swift
//  Just Right There
//
//  Created by Komran Ghahremani on 11/29/15.
//  Copyright © 2015 Komran Ghahremani. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController, UITextFieldDelegate {
    var logoImageView: UIImageView
    var subtitleLabel: UILabel
    var signupButton: UIButton
    var loginButton: UIButton
    var needHelpButton: UIButton
    var userDefaults: NSUserDefaults
    
    var usernameTextField: UITextField
    var passwordTextField: UITextField
    var enterButton: UIButton
    
    var usernameUnderlineView: UIView
    var passwordUnderlineView: UIView
    
    var errorView: ErrorDropView
    var errorViewConstraint: NSLayoutConstraint?
    
    init() {
        logoImageView = UIImageView()
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = UIImage(named: "logo")
        logoImageView.contentMode = .ScaleAspectFit
        
        subtitleLabel = UILabel()
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.backgroundColor = ClearColor
        subtitleLabel.textColor = WhiteColor
        subtitleLabel.numberOfLines = 2
        subtitleLabel.text = "Location based lists to add order to your shopping experience"
        subtitleLabel.font = UIFont(name: "Avenir-Book", size: 13.0)
        subtitleLabel.textAlignment = .Center
        
        signupButton = UIButton()
        signupButton.translatesAutoresizingMaskIntoConstraints = false
        signupButton.setTitle("SIGN UP", forState: .Normal)
        signupButton.titleLabel?.font = UIFont(name: "Avenir-Book", size: 16.0)
        signupButton.backgroundColor = WhiteColor
        signupButton.setTitleColor(FlatGreenColor, forState: .Normal)
        signupButton.layer.cornerRadius = 5.0
        
        loginButton = UIButton()
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.setTitle("LOG IN", forState: .Normal)
        loginButton.titleLabel?.font = UIFont(name: "Avenir-Book", size: 16.0)
        loginButton.backgroundColor = WhiteColor
        loginButton.setTitleColor(FlatGreenColor, forState: .Normal)
        loginButton.layer.cornerRadius = 5.0
        
        needHelpButton = UIButton()
        needHelpButton.translatesAutoresizingMaskIntoConstraints = false
        needHelpButton.setTitle("Need Help?", forState: .Normal)
        needHelpButton.setTitleColor(WhiteColor, forState: .Normal)
        needHelpButton.titleLabel?.font = UIFont.systemFontOfSize(14.0)
        
        userDefaults = NSUserDefaults.standardUserDefaults()
        
        let usernamePaddingView = UIView(frame: CGRectMake(0, 0, 5, 20))
        let passwordPaddingView = UIView(frame: CGRectMake(0, 0, 5, 20))
        
        usernameTextField = UITextField()
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        usernameTextField.placeholder = "Username"
        usernameTextField.font = UIFont(name: "Avenir", size: 13.0)
        usernameTextField.textColor = FlatGreenColor
        usernameTextField.backgroundColor = WhiteColor
        usernameTextField.layer.cornerRadius = 5.0
        usernameTextField.alpha = 0.0
        usernameTextField.leftView = usernamePaddingView
        usernameTextField.leftViewMode = .Always
        usernameTextField.returnKeyType = .Done
        
        passwordTextField = UITextField()
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.placeholder = "  Password"
        passwordTextField.textColor = FlatGreenColor
        passwordTextField.font = UIFont(name: "Avenir", size: 13.0)
        passwordTextField.backgroundColor = WhiteColor
        passwordTextField.layer.cornerRadius = 3.0
        passwordTextField.alpha = 0.0
        passwordTextField.leftView = passwordPaddingView
        passwordTextField.leftViewMode = .Always
        passwordTextField.returnKeyType = .Done
        passwordTextField.secureTextEntry = true
        
        enterButton = UIButton()
        enterButton.translatesAutoresizingMaskIntoConstraints = false
        enterButton.setTitle("Done", forState: .Normal)
        enterButton.setTitleColor(FlatGreenColor, forState: .Normal)
        enterButton.titleLabel?.font = UIFont(name: "Avenir-Book", size: 14.0)
        enterButton.backgroundColor = UIColor.whiteColor()
        enterButton.layer.cornerRadius = 3.0
        enterButton.alpha = 0.0
        
        usernameUnderlineView = UIView()
        usernameUnderlineView.translatesAutoresizingMaskIntoConstraints = false
        usernameUnderlineView.backgroundColor = UIColor.whiteColor()
        usernameUnderlineView.alpha = 0.0
        
        passwordUnderlineView = UIView()
        passwordUnderlineView.translatesAutoresizingMaskIntoConstraints = false
        passwordUnderlineView.backgroundColor = UIColor.whiteColor()
        passwordUnderlineView.alpha = 0.0
        
        errorView = ErrorDropView()
        errorView.translatesAutoresizingMaskIntoConstraints = false
        
        super.init(nibName: nil, bundle: nil)
        
        view.backgroundColor = FlatGreenColor
        
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        
        signupButton.addTarget(self, action: "showTextFields:", forControlEvents: .TouchUpInside)
        loginButton.addTarget(self, action: "showTextFields:", forControlEvents: .TouchUpInside)
        enterButton.addTarget(self, action: "enterButtonTapped", forControlEvents: .TouchUpInside)
        
        view.addSubview(usernameTextField)
        view.addSubview(passwordTextField)
        view.addSubview(enterButton)
        view.addSubview(usernameUnderlineView)
        view.addSubview(passwordUnderlineView)
        
        view.addSubview(logoImageView)
        view.addSubview(subtitleLabel)
        view.addSubview(signupButton)
        view.addSubview(loginButton)
        view.addSubview(needHelpButton)
        
        view.addSubview(errorView)
        
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func showTextFields(button: UIButton) {
        UIView.animateWithDuration(0.4, animations: {
            self.signupButton.alpha = 0.0
            self.loginButton.alpha = 0.0
        })
        
        view.sendSubviewToBack(signupButton)
        view.sendSubviewToBack(loginButton)
        
        UIView.animateWithDuration(0.4, animations: {
            if button == self.signupButton {
                self.subtitleLabel.text = "Choose your username and password for \nyour Dreamscape account."
            } else {
                self.subtitleLabel.text = "Enter your username and password to login \nto your Dreamscape account."
            }
            
            self.enterButton.alpha = 1.0
            
            self.usernameUnderlineView.alpha = 1.0
            self.usernameTextField.alpha = 1.0
            self.usernameTextField.backgroundColor = UIColor.clearColor()
            self.usernameTextField.textColor = UIColor.whiteColor()
            self.usernameTextField.attributedPlaceholder = NSAttributedString(string:"Username",
                attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()])
            
            self.passwordUnderlineView.alpha = 1.0
            self.passwordTextField.alpha = 1.0
            self.passwordTextField.backgroundColor = UIColor.clearColor()
            self.passwordTextField.textColor = UIColor.whiteColor()
            self.passwordTextField.attributedPlaceholder = NSAttributedString(string:"Password",
                attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()])
        })
    }
    
    func enterButtonTapped() {
        let dreamDictionary = ["username":usernameTextField.text!, "password":passwordTextField.text!]
        let userRef = rootRef.childByAppendingPath("users")
        let newPostRef: Firebase = userRef.childByAutoId()
        
        let stringRef = newPostRef.key
        print(stringRef)
        
        if usernameTextField.text?.characters.count >= 5 && passwordTextField.text?.characters.count >= 5 {
            if let username = usernameTextField.text {
                newPostRef.setValue(dreamDictionary)
                userDefaults.setBool(true, forKey: "JRTuser")
                userDefaults.setValue("\(username)", forKey: "username")
                userDefaults.setValue("\(passwordTextField.text)", forKey: "password")
                userDefaults.setValue("\(stringRef)", forKey: "id")
                dismissViewControllerAnimated(true, completion: nil)
            }
        } else if passwordTextField.text?.characters.count < 5 && usernameTextField.text?.characters.count < 3 {
            errorView.setErrorText(.Username)
            showError()
            delay(3.0, closure: {
                self.hideError()
            })
        } else if usernameTextField.text?.characters.count < 3 {
            errorView.setErrorText(.Username)
            showError()
            delay(3.0, closure: {
                self.hideError()
            })
        } else if passwordTextField.text?.characters.count < 5 {
            errorView.setErrorText(.Password)
            showError()
            delay(3.0, closure: {
                self.hideError()
            })
        }
    }
    
    func showError() {
        errorViewConstraint?.constant = 25
        
        UIView.animateWithDuration(0.4, animations: {
            self.view.layoutSubviews()
        })
    }
    
    func hideError() {
        errorViewConstraint?.constant = 0
        
        UIView.animateWithDuration(0.4, animations: {
            self.view.layoutSubviews()
        })
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        textField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    func setupLayout() {
        errorViewConstraint = errorView.al_bottom == view.al_top
        
        view.addConstraints([
            logoImageView.al_top == view.al_top + 60,
            logoImageView.al_left == view.al_left + 50,
            logoImageView.al_right == view.al_right - 50,
            logoImageView.al_height == 60,
            
            subtitleLabel.al_centerX == view.al_centerX,
            subtitleLabel.al_top == logoImageView.al_bottom,
            subtitleLabel.al_height == 60,
            subtitleLabel.al_width == 300,
            
            signupButton.al_top == logoImageView.al_bottom + 100,
            signupButton.al_centerX == view.al_centerX,
            signupButton.al_width == 300,
            signupButton.al_height == 50,
            
            loginButton.al_top == signupButton.al_bottom + 10,
            loginButton.al_centerX == view.al_centerX,
            loginButton.al_height == 50,
            loginButton.al_width == 300,
            
            needHelpButton.al_centerX == view.al_centerX,
            needHelpButton.al_bottom == view.al_bottom - 15,
            needHelpButton.al_width == 80,
            needHelpButton.al_height == 30,
            
            usernameTextField.al_centerX == view.al_centerX,
            usernameTextField.al_height == 40,
            usernameTextField.al_width == 300,
            usernameTextField.al_centerY == signupButton.al_centerY,
            
            passwordTextField.al_centerX == view.al_centerX,
            passwordTextField.al_height == 40,
            passwordTextField.al_width == 300,
            passwordTextField.al_top == usernameTextField.al_bottom + 10,
            
            enterButton.al_centerX == view.al_centerX,
            enterButton.al_top == passwordTextField.al_bottom + 20,
            enterButton.al_height == 30,
            enterButton.al_width == 140
        ])
        
        view.addConstraints([
            usernameUnderlineView.al_centerX == view.al_centerX,
            usernameUnderlineView.al_top == usernameTextField.al_bottom,
            usernameUnderlineView.al_width == usernameTextField.al_width,
            usernameUnderlineView.al_height == 1,
            
            passwordUnderlineView.al_centerX == view.al_centerX,
            passwordUnderlineView.al_top == passwordTextField.al_bottom,
            passwordUnderlineView.al_width == passwordTextField.al_width,
            passwordUnderlineView.al_height == 1,
            
            errorView.al_left == view.al_left,
            errorView.al_right == view.al_right,
            errorViewConstraint!,
            errorView.al_height == 25
        ])
    }
}
