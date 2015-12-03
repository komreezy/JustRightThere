//
//  SpecialsAndPromotionsCollectionViewController.swift
//  Just Right There
//
//  Created by Komran Ghahremani on 11/14/15.
//  Copyright © 2015 Komran Ghahremani. All rights reserved.
//

import UIKit

private let specialsReuseIdentifier = "specialsCell"

class SpecialsAndPromotionsCollectionViewController: UICollectionViewController {

    init() {
        super.init(collectionViewLayout: SpecialsAndPromotionsCollectionViewController.provideCollectionViewLayout())
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class func provideCollectionViewLayout() -> UICollectionViewLayout {
        let screenWidth = UIScreen.mainScreen().bounds.size.width
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        flowLayout.sectionInset = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)
        flowLayout.itemSize = CGSizeMake(screenWidth, 200)
        return flowLayout
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Register cell classes
        if let collectionView = collectionView {
            collectionView.backgroundColor = WhiteColor
            collectionView.registerClass(SpecialsCollectionViewCell.self, forCellWithReuseIdentifier: specialsReuseIdentifier)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(specialsReuseIdentifier, forIndexPath: indexPath) as? SpecialsCollectionViewCell
    
        if indexPath.row % 2 == 0 {
            cell?.small = false
        }
    
        return cell!
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if let navigationController = navigationController {
            navigationController.pushViewController(DealViewController(), animated: true)
        }
    }
}
