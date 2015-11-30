//
//  SpecialsCollectionViewCell.swift
//  Just Right There
//
//  Created by Komran Ghahremani on 11/19/15.
//  Copyright © 2015 Komran Ghahremani. All rights reserved.
//

import UIKit

class SpecialsCollectionViewCell: UICollectionViewCell {
    var specialNameLabel: UILabel
    var borderView: UIView
    var small: Bool
    
    init(frame: CGRect, small: Bool) {
        self.small = small
        
        specialNameLabel = UILabel()
        specialNameLabel.translatesAutoresizingMaskIntoConstraints = false
        specialNameLabel.textColor = FlatBlackColor
        
        borderView = UIView()
        borderView.translatesAutoresizingMaskIntoConstraints = false
        borderView.backgroundColor = UIColor(fromHexString: "#CCCCCC")
        
        super.init(frame: frame)
        
        addSubview(specialNameLabel)
        addSubview(borderView)
        
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        addConstraints([
            specialNameLabel.al_centerY == al_centerY,
            specialNameLabel.al_left == al_left + 25,
            
            borderView.al_left == al_left,
            borderView.al_width == al_width,
            borderView.al_bottom == al_bottom,
            borderView.al_height == 0.5
        ])
    }
}
