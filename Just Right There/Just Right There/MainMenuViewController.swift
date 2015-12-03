    //
//  ViewController.swift
//  Just Right There
//
//  Created by Komran Ghahremani on 8/25/15.
//  Copyright (c) 2015 Komran Ghahremani. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {
    var addToShoppingListButton: SpringButton
    var addLocationButton: SpringButton
    var specialsButton: SpringButton
    
    var addToShoppingLabel: UILabel
    var addLocationLabel: UILabel
    var specialsLabel: UILabel
    
    var userDefaults: NSUserDefaults
    
    var addToShoppingListAnimationConstraint: NSLayoutConstraint?
    
    init() {
        userDefaults = NSUserDefaults.standardUserDefaults()
        
        addToShoppingListButton = SpringButton()
        addToShoppingListButton.translatesAutoresizingMaskIntoConstraints = false
        addToShoppingListButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        addToShoppingListButton.layer.cornerRadius = 85
        addToShoppingListButton.backgroundColor = FlatGreenColor
        
        addLocationButton = SpringButton()
        addLocationButton.translatesAutoresizingMaskIntoConstraints = false
        addLocationButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        addLocationButton.layer.cornerRadius = 85
        addLocationButton.backgroundColor = FlatBlueColor
        
        specialsButton = SpringButton()
        specialsButton.translatesAutoresizingMaskIntoConstraints = false
        specialsButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        specialsButton.layer.cornerRadius = 85
        specialsButton.backgroundColor = FlatRedColor
        
        addToShoppingLabel = UILabel()
        addToShoppingLabel.translatesAutoresizingMaskIntoConstraints = false
        addToShoppingLabel.text = "Add to \nShopping List"
        addToShoppingLabel.numberOfLines = 2
        addToShoppingLabel.textAlignment = .Center
        addToShoppingLabel.font = UIFont.systemFontOfSize(20)
        addToShoppingLabel.textColor = UIColor.whiteColor()
        
        addLocationLabel = UILabel()
        addLocationLabel.translatesAutoresizingMaskIntoConstraints = false
        addLocationLabel.text = "Add a New \nList Location"
        addLocationLabel.numberOfLines = 2
        addLocationLabel.textAlignment = .Center
        addLocationLabel.font = UIFont.systemFontOfSize(20)
        addLocationLabel.textColor = UIColor.whiteColor()
        
        specialsLabel = UILabel()
        specialsLabel.translatesAutoresizingMaskIntoConstraints = false
        specialsLabel.text = "Specials\n and Deals"
        specialsLabel.numberOfLines = 2
        specialsLabel.textAlignment = .Center
        specialsLabel.font = UIFont.systemFontOfSize(20)
        specialsLabel.textColor = UIColor.whiteColor()
        
        super.init(nibName: nil, bundle: nil)
        
        addToShoppingListButton.addTarget(self, action: "addToShoppingListTapped",forControlEvents: .TouchUpInside)
        addLocationButton.addTarget(self, action: "addLocationTapped", forControlEvents: .TouchUpInside)
        specialsButton.addTarget(self, action: "specialsTapped", forControlEvents: .TouchUpInside)
        
        view.backgroundColor = UIColor.whiteColor()
        
        addToShoppingListButton.addSubview(addToShoppingLabel)
        addLocationButton.addSubview(addLocationLabel)
        specialsButton.addSubview(specialsLabel)
        
        view.addSubview(addToShoppingListButton)
        view.addSubview(addLocationButton)
        view.addSubview(specialsButton)
        
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    override func viewDidAppear(animated: Bool) {
        if userDefaults.boolForKey("JRTuser") == false {
            let vc = SignupViewController()
            presentViewController(vc, animated: true, completion: nil)
        }
        
        title = "Main Menu"
        myNavigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: WhiteColor]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager.requestListData()
        
        addToShoppingListButton.duration = 1.2
        addToShoppingListButton.animation = "pop"
        addToShoppingListButton.curve = "easeInOut"
        addToShoppingListButton.animate()
        
        delay(0.3, closure: {
            self.addLocationButton.duration = 1.2
            self.addLocationButton.animation = "pop"
            self.addLocationButton.curve = "easeInOut"
            self.addLocationButton.animate()
        })
        
        delay(0.6, closure: {
            self.specialsButton.duration = 1.2
            self.specialsButton.animation = "pop"
            self.specialsButton.curve = "easeInOut"
            self.specialsButton.animate()
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func addToShoppingListTapped() {
        if let navigationController = navigationController {
            navigationController.pushViewController(ListsTableViewController(), animated: true)
        }
    }
    
    func addLocationTapped() {
        if let navigationController = navigationController {
            navigationController.pushViewController(MapSearchViewController(), animated: true)
        }
    }
    
    func specialsTapped() {
        if let navigationController = navigationController {
            navigationController.pushViewController(SpecialsAndPromotionsCollectionViewController(), animated: true)
        }
    }

    func setupLayout() {
        addToShoppingListAnimationConstraint = addToShoppingListButton.al_centerX == view.al_centerX
        
        view.addConstraints([
            addToShoppingListButton.al_width == 170,
            addToShoppingListButton.al_height == 170,
            addToShoppingListAnimationConstraint!,
            addToShoppingListButton.al_bottom == addLocationButton.al_top - 20,
            
            addLocationButton.al_width == 170,
            addLocationButton.al_height == 170,
            addLocationButton.al_centerX == view.al_centerX,
            addLocationButton.al_bottom == specialsButton.al_top - 20,
            
            specialsButton.al_width == 170,
            specialsButton.al_height == 170,
            specialsButton.al_centerX == view.al_centerX,
            specialsButton.al_bottom == view.al_bottom - UIScreen.mainScreen().bounds.height / 10,
            
            addToShoppingLabel.al_centerX == addToShoppingListButton.al_centerX,
            addToShoppingLabel.al_centerY == addToShoppingListButton.al_centerY,
            
            addLocationLabel.al_centerX == addLocationButton.al_centerX,
            addLocationLabel.al_centerY == addLocationButton.al_centerY,
            
            specialsLabel.al_centerX == specialsButton.al_centerX,
            specialsLabel.al_centerY == specialsButton.al_centerY
        ])
    }
}

