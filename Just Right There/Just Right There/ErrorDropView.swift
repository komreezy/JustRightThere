//
//  ErrorDropView.swift
//  Just Right There
//
//  Created by Komran Ghahremani on 11/29/15.
//  Copyright © 2015 Komran Ghahremani. All rights reserved.
//

import UIKit

class ErrorDropView: UILabel {

    enum LoginError {
        case Username
        case Password
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = FlatRedColor
        textAlignment = .Center
        textColor = UIColor.whiteColor()
        font = UIFont(name: "HelveticaNeue", size: 13.0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setErrorText(error: LoginError) {
        switch error {
        case .Username:
            text = "Usernames must be at least 3 letters"
        case .Password:
            text = "Passwords must be at least 5 letters"
        }
    }
}
