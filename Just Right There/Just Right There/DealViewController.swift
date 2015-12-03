//
//  DealViewController.swift
//  Just Right There
//
//  Created by Komran Ghahremani on 11/30/15.
//  Copyright © 2015 Komran Ghahremani. All rights reserved.
//

import UIKit

class DealViewController: UIViewController {

    init() {
        super.init(nibName: nil, bundle: nil)
        
        view.backgroundColor = WhiteColor
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
