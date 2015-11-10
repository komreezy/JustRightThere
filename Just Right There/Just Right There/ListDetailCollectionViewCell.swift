//
//  ListDetailCollectionViewCell.swift
//  Just Right There
//
//  Created by Komran Ghahremani on 10/15/15.
//  Copyright © 2015 Komran Ghahremani. All rights reserved.
//

import UIKit

class ListDetailCollectionViewCell: UICollectionViewCell {
    var itemNameLabel: UILabel
    var borderView: UIView
    
    override init(frame: CGRect) {
        itemNameLabel = UILabel()
        itemNameLabel.translatesAutoresizingMaskIntoConstraints = false
        itemNameLabel.textColor = FlatBlackColor
        
        borderView = UIView()
        borderView.translatesAutoresizingMaskIntoConstraints = false
        borderView.backgroundColor = UIColor(fromHexString: "#CCCCCC")
        
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
            itemNameLabel.al_centerY == al_centerY,
            itemNameLabel.al_left == al_left + 15,
            
            borderView.al_left == al_left,
            borderView.al_right == al_right,
            borderView.al_bottom == al_bottom,
            borderView.al_height == 0.5
        ])
    }
}
