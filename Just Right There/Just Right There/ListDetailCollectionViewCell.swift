//
//  ListDetailCollectionViewCell.swift
//  Just Right There
//
//  Created by Komran Ghahremani on 10/15/15.
//  Copyright © 2015 Komran Ghahremani. All rights reserved.
//

import UIKit

class ListDetailCollectionViewCell: UICollectionViewCell {
    var itemNameLabel: UITextField
    var borderView: UIView
    var deleteButton: UIButton
    
    override init(frame: CGRect) {
        itemNameLabel = UITextField()
        itemNameLabel.translatesAutoresizingMaskIntoConstraints = false
        itemNameLabel.textColor = FlatBlackColor
        itemNameLabel.returnKeyType = .Done
        
        borderView = UIView()
        borderView.translatesAutoresizingMaskIntoConstraints = false
        borderView.backgroundColor = UIColor(fromHexString: "#CCCCCC")
        
        deleteButton = UIButton()
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.backgroundColor = FlatRedColor
        deleteButton.setTitle("Delete", forState: .Normal)
        deleteButton.setTitleColor(WhiteColor, forState: .Normal)
        
        super.init(frame: frame)
        
        addSubview(itemNameLabel)
        addSubview(borderView)
        
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        addConstraints([
            itemNameLabel.al_left == al_left + 25,
            itemNameLabel.al_right == al_right - 25,
            itemNameLabel.al_top == al_top,
            itemNameLabel.al_bottom == al_bottom,
            
            borderView.al_left == al_left,
            borderView.al_width == al_width,
            borderView.al_bottom == al_bottom,
            borderView.al_height == 0.5
        ])
    }
}
