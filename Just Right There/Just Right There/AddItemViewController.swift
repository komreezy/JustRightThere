//
//  AddItemViewController.swift
//  Just Right There
//
//  Created by Komran Ghahremani on 10/17/15.
//  Copyright © 2015 Komran Ghahremani. All rights reserved.
//

import UIKit

class AddItemViewController: UIViewController {
    var itemNameLabel: UILabel
    var itemNameTextField: UITextField
    var doneButton: UIButton
    
    init() {
        itemNameLabel = UILabel()
        itemNameLabel.translatesAutoresizingMaskIntoConstraints = false
        itemNameLabel.text = "Name"
        
        itemNameTextField = UITextField()
        itemNameTextField.translatesAutoresizingMaskIntoConstraints = false
        itemNameTextField.backgroundColor = UIColor.lightGrayColor()
        
        doneButton = UIButton()
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.setTitle("Done", forState: .Normal)
        doneButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        doneButton.layer.cornerRadius = 5
        doneButton.layer.borderColor = UIColor.blackColor().CGColor
        doneButton.layer.borderWidth = 3
        
        super.init(nibName: nil, bundle: nil)
        
        view.backgroundColor = UIColor.whiteColor()
        
        doneButton.addTarget(self, action: "doneTapped", forControlEvents: .TouchUpInside)
        
        view.addSubview(itemNameLabel)
        view.addSubview(itemNameTextField)
        view.addSubview(doneButton)
        
        setupLayout()
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
    
    func doneTapped() {
        if let name = itemNameTextField.text {
            manager.lists[manager.currentIndex].items.append(name)
            dismissViewControllerAnimated(true, completion: nil)
        } else {
            print("No Text")
        }
    }
    
    func setupLayout() {
        view.addConstraints([
            itemNameLabel.al_centerX == view.al_centerX,
            itemNameLabel.al_height == 30,
            itemNameLabel.al_top == view.al_top + 30,
            
            itemNameTextField.al_centerX == view.al_centerX,
            itemNameTextField.al_width == UIScreen.mainScreen().bounds.width - 60,
            itemNameTextField.al_top == itemNameLabel.al_bottom + 20,
            
            doneButton.al_centerX == view.al_centerX,
            doneButton.al_top == itemNameTextField.al_bottom + 20,
            doneButton.al_width == 100,
            doneButton.al_height == 40
        ])
    }
}
