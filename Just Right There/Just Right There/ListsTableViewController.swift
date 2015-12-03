//
//  ListsTableViewController.swift
//  Just Right There
//
//  Created by Komran Ghahremani on 11/19/15.
//  Copyright © 2015 Komran Ghahremani. All rights reserved.
//

import UIKit

let listCellReuseIdentifier = "listCell"

class ListsTableViewController: UITableViewController, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    var selectedIndex = 0
    
    init() {
        super.init(style: .Plain)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        myNavigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: WhiteColor]
        title = "My Lists"
        
        if let tableView = tableView {
            tableView.backgroundColor = UIColor.whiteColor()
            tableView.showsVerticalScrollIndicator = false
            tableView.emptyDataSetSource = self
            tableView.emptyDataSetDelegate = self
            tableView.registerClass(ListTableViewCell.self, forCellReuseIdentifier: listCellReuseIdentifier)
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: DZNEmptyDataSet
    func imageForEmptyDataSet(scrollView: UIScrollView!) -> UIImage! {
        return UIImage(named: "")
    }
    
    func titleForEmptyDataSet(scrollView: UIScrollView!) -> NSAttributedString! {
        let title = "No Lists yet"
        let myMutableString = NSMutableAttributedString(
            string: title,
            attributes: [NSFontAttributeName:UIFont(
                name: "HelveticaNeue",
                size: 24.0)!, NSForegroundColorAttributeName: FlatBlackColor])
        return myMutableString
    }
    
    func descriptionForEmptyDataSet(scrollView: UIScrollView!) -> NSAttributedString! {
        let title = "Add a List Location by tapping on the blue 'Add a New List Location' button in the Main Menu and searching for a location you want to make a list for."
        let myMutableString = NSMutableAttributedString(
            string: title,
            attributes: [NSFontAttributeName:UIFont(
                name: "HelveticaNeue",
                size: 18.0)!, NSForegroundColorAttributeName: FlatBlackColor])
        return myMutableString
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60.0
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return manager.lists.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(listCellReuseIdentifier, forIndexPath: indexPath) as? ListTableViewCell
        
        cell!.nameLabel.text = manager.lists[indexPath.row].title
        cell!.itemCountLabel.text = String("\(manager.lists[indexPath.row].items.count) Items")
        
        return cell!
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let navigationController = navigationController {
            manager.currentIndex = indexPath.row
            navigationController.pushViewController(ListDetailViewController(), animated: true)
        }
    }
}
