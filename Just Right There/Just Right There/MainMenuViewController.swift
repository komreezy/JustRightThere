    //
//  ViewController.swift
//  Just Right There
//
//  Created by Komran Ghahremani on 8/25/15.
//  Copyright (c) 2015 Komran Ghahremani. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {
    var addToShoppingListButton: UIButton
    var addLocationButton: UIButton
    var specialsButton: UIButton
    
    init() {
        addToShoppingListButton = UIButton()
        addToShoppingListButton.translatesAutoresizingMaskIntoConstraints = false
        addToShoppingListButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        addToShoppingListButton.layer.cornerRadius = 80
        addToShoppingListButton.backgroundColor = UIColor.redColor()
        
        addLocationButton = UIButton()
        addLocationButton.translatesAutoresizingMaskIntoConstraints = false
        addLocationButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        addLocationButton.layer.cornerRadius = 80
        addLocationButton.backgroundColor = UIColor.blueColor()
        
        specialsButton = UIButton()
        specialsButton.translatesAutoresizingMaskIntoConstraints = false
        specialsButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        specialsButton.layer.cornerRadius = 80
        specialsButton.backgroundColor = UIColor.yellowColor()
        
        super.init(nibName: nil, bundle: nil)
        
        addToShoppingListButton.addTarget(self, action: "addToShoppingListTapped",forControlEvents: .TouchUpInside)
        addLocationButton.addTarget(self, action: "addLocationTapped", forControlEvents: .TouchUpInside)
        
        view.backgroundColor = UIColor.whiteColor()
        
        view.addSubview(addToShoppingListButton)
        view.addSubview(addLocationButton)
        view.addSubview(specialsButton)
        
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
    }
    
    func addToShoppingListTapped() {
        if let navigationController = navigationController {
            navigationController.pushViewController(ListsCollectionViewController(), animated: true)
        }
    }
    
    func addLocationTapped() {
        if let navigationController = navigationController {
            navigationController.pushViewController(MapSearchViewController(), animated: true)
        }
    }

    func setupLayout() {
        view.addConstraints([
            addToShoppingListButton.al_width == 160,
            addToShoppingListButton.al_height == 160,
            addToShoppingListButton.al_centerX == view.al_centerX,
            addToShoppingListButton.al_bottom == addLocationButton.al_top - 20,
            
            addLocationButton.al_width == 160,
            addLocationButton.al_height == 160,
            addLocationButton.al_centerX == view.al_centerX,
            addLocationButton.al_bottom == specialsButton.al_top - 20,
            
            specialsButton.al_width == 160,
            specialsButton.al_height == 160,
            specialsButton.al_centerX == view.al_centerX,
            specialsButton.al_bottom == view.al_bottom - UIScreen.mainScreen().bounds.height / 10
        ])
    }
}

