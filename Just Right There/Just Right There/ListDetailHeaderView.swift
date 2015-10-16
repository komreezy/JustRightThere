//
//  ListDetailHeaderView.swift
//  Just Right There
//
//  Created by Komran Ghahremani on 10/15/15.
//  Copyright © 2015 Komran Ghahremani. All rights reserved.
//

import UIKit

class ListDetailHeaderView: UICollectionReusableView, ListDetailHeaderDelegate {
    var titleLabel: UILabel // will be set by the current title variable
    var rangeSlider: UISlider // range of notification
    
    var sliderNumbers = [0, 0.5, 1, 1.5, 2, 2.5, 3, 3.5, 4, 4.5, 5]
    var numberOfSteps: Float = 10
    
    override init(frame: CGRect) {
        titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Nike Store"
        titleLabel.backgroundColor = UIColor.clearColor()
        
        rangeSlider = UISlider()
        rangeSlider.translatesAutoresizingMaskIntoConstraints = false
        rangeSlider.maximumValue = numberOfSteps
        rangeSlider.minimumValue = 0
        rangeSlider.continuous = true
        rangeSlider.layer.cornerRadius = 10
        
        super.init(frame: frame)
        
        backgroundColor = UIColor.whiteColor()
        
        rangeSlider.addTarget(self, action: "sliderValueChanged", forControlEvents: .TouchUpInside)
        
        addSubview(titleLabel)
        addSubview(rangeSlider)
        
        setupLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // UISlider
    func sliderValueChanged() {
        UIView.animateWithDuration(0.3, animations: {
            self.rangeSlider.backgroundColor = UIColor(fromHexString: "#e74c3c")
        })
        
        var value: CGFloat = 0.0
        rangeSlider.value = floor(rangeSlider.value)
        value = CGFloat(rangeSlider.value / 2)
        print(value)
        
        manager.createLocationBasedNotification(titleLabel.text!, radius: value)
        
        UIView.animateWithDuration(0.3, animations: {
            self.rangeSlider.backgroundColor = UIColor(fromHexString: "#ffffff")
        })
    }
    
    // MARK: ListDetailHeaderDelegate
    func fillHeaderValues(title: String) {
        titleLabel.text = title
    }
    
    func setupLayout() {
        addConstraints([
            titleLabel.al_centerX == al_centerX,
            titleLabel.al_top == al_top + 70,
            
            rangeSlider.al_left == al_left + 20,
            rangeSlider.al_right == al_right - 20,
            rangeSlider.al_top == titleLabel.al_bottom + 5,
            rangeSlider.al_height == 45
        ])
    }
}
