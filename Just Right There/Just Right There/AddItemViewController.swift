//
//  AddItemViewController.swift
//  Just Right There
//
//  Created by Komran Ghahremani on 10/17/15.
//  Copyright © 2015 Komran Ghahremani. All rights reserved.
//

import UIKit

class AddItemViewController: UIViewController {
    var itemNameTextField: UITextField
    var doneButton: UIButton
    var underlineView: UIView
    var cancelButton: UIButton
    
    init() {
        itemNameTextField = UITextField()
        itemNameTextField.translatesAutoresizingMaskIntoConstraints = false
        itemNameTextField.backgroundColor = ClearColor
        itemNameTextField.placeholder = "Name of Item"
        itemNameTextField.textColor = WhiteColor
        itemNameTextField.font = UIFont.systemFontOfSize(24.0)
        
        underlineView = UIView()
        underlineView.translatesAutoresizingMaskIntoConstraints = false
        underlineView.backgroundColor = WhiteColor
        underlineView.layer.cornerRadius = 3
        
        cancelButton = UIButton()
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.setImage(UIImage(named: "close"), forState: .Normal)
        
        doneButton = UIButton()
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.setTitle("Done", forState: .Normal)
        doneButton.setTitleColor(WhiteColor, forState: .Normal)
        doneButton.layer.cornerRadius = 5
        doneButton.layer.borderColor = WhiteColor.CGColor
        doneButton.layer.borderWidth = 2
        
        super.init(nibName: nil, bundle: nil)
        
        view.backgroundColor = FlatGreenColor
        
        doneButton.addTarget(self, action: "doneTapped", forControlEvents: .TouchUpInside)
        cancelButton.addTarget(self, action: "closeTapped", forControlEvents: .TouchUpInside)
        
        view.addSubview(itemNameTextField)
        view.addSubview(underlineView)
        view.addSubview(doneButton)
        view.addSubview(cancelButton)
        
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
            if let id = NSUserDefaults.standardUserDefaults().stringForKey("id") {
                let listId = manager.lists[manager.currentIndex].id
                let dreamDictionary = ["name":"\(name)"]
                let userRef = rootRef.childByAppendingPath("users/\(id)/lists/\(listId)/items")
                let newPostRef: Firebase = userRef.childByAutoId()
                
                var newItem = Item(name: name, id: "")
                newItem.id = newPostRef.key
                manager.lists[manager.currentIndex].items.append(newItem)
                
                newPostRef.setValue(dreamDictionary)
            }
            
            dismissViewControllerAnimated(true, completion: nil)
        } else {
            print("No Text")
        }
    }
    
    func closeTapped() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func setupLayout() {
        view.addConstraints([
            itemNameTextField.al_centerX == view.al_centerX,
            itemNameTextField.al_width == UIScreen.mainScreen().bounds.width - 100,
            itemNameTextField.al_top == view.al_top + 115,
            
            underlineView.al_left == itemNameTextField.al_left,
            underlineView.al_right == itemNameTextField.al_right,
            underlineView.al_top == itemNameTextField.al_bottom + 10,
            underlineView.al_height == 2,
            
            cancelButton.al_height == 50,
            cancelButton.al_width == cancelButton.al_height,
            cancelButton.al_top == view.al_top + 20,
            cancelButton.al_left == view.al_left + 5,
            
            doneButton.al_centerX == view.al_centerX,
            doneButton.al_top == underlineView.al_bottom + 30,
            doneButton.al_width == 120,
            doneButton.al_height == 35
        ])
    }
}
