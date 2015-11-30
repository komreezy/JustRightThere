//
//  ListTableViewCell.swift
//  Just Right There
//
//  Created by Komran Ghahremani on 11/19/15.
//  Copyright © 2015 Komran Ghahremani. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    var bottomEditView: UIView
    var deleteButton: UIButton
    
    var topContainerView: UIView
    var nameLabel: UILabel
    var itemCountLabel: UILabel
    var borderView: UIView
    
    var swipeRecognizer: UIPanGestureRecognizer?
    var topContainerRightConstraint: NSLayoutConstraint?
    var deleteButtonRightConstraint: NSLayoutConstraint?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        topContainerView = UIView()
        topContainerView.translatesAutoresizingMaskIntoConstraints = false
        topContainerView.backgroundColor = WhiteColor
        
        bottomEditView = UIView()
        bottomEditView.translatesAutoresizingMaskIntoConstraints = false
        bottomEditView.backgroundColor = FlatRedColor
        
        deleteButton = UIButton()
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.backgroundColor = ClearColor
        deleteButton.setTitle("Delete", forState: .Normal)
        deleteButton.setTitleColor(WhiteColor, forState: .Normal)
        
        nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.text = "Nike"
        
        itemCountLabel = UILabel()
        itemCountLabel.translatesAutoresizingMaskIntoConstraints = false
        itemCountLabel.text = "3 Items"
        
        borderView = UIView()
        borderView.translatesAutoresizingMaskIntoConstraints = false
        borderView.backgroundColor = UIColor(fromHexString: "#CCCCCC")
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        swipeRecognizer = UIPanGestureRecognizer(target: self, action: "swipeToDelete:")
        topContainerView.addGestureRecognizer(swipeRecognizer!)
        
        bottomEditView.addSubview(deleteButton)
        addSubview(bottomEditView)
        
        topContainerView.addSubview(nameLabel)
        topContainerView.addSubview(itemCountLabel)
        topContainerView.addSubview(borderView)
        addSubview(topContainerView)
        
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func swipeToDelete(recognizer: UIPanGestureRecognizer) {
        var startLocation: CGPoint = CGPoint(x: 0.0, y: 0.0)
        
        if recognizer.state == .Began {
            startLocation = recognizer.locationInView(self)
        } else if recognizer.state == .Ended {
            let stopLocation = recognizer.locationInView(self)
            let dx = stopLocation.x - startLocation.x
            
            
        }
        
    }
    
    func setupLayout() {
        topContainerRightConstraint = topContainerView.al_right == al_right
        deleteButtonRightConstraint = deleteButton.al_right == bottomEditView.al_right
        addConstraints([
            bottomEditView.al_left == al_left,
            bottomEditView.al_top == al_top,
            bottomEditView.al_bottom == al_bottom,
            bottomEditView.al_right == al_right,
            
            deleteButtonRightConstraint!,
            deleteButton.al_centerY == bottomEditView.al_centerY,
            deleteButton.al_height == bottomEditView.al_height,
            deleteButton.al_width == deleteButton.al_height,
            
            topContainerView.al_left == al_left,
            topContainerView.al_top == al_top,
            topContainerView.al_bottom == al_bottom,
            topContainerRightConstraint!,
            
            nameLabel.al_centerY == topContainerView.al_centerY,
            nameLabel.al_left == topContainerView.al_left + 25,
            
            itemCountLabel.al_centerY == topContainerView.al_centerY,
            itemCountLabel.al_right == topContainerView.al_right - 25,
            
            borderView.al_left == topContainerView.al_left,
            borderView.al_width == topContainerView.al_width,
            borderView.al_bottom == topContainerView.al_bottom,
            borderView.al_height == 0.5
        ])
    }
}
