//
//  ListsTableViewController.swift
//  Just Right There
//
//  Created by Komran Ghahremani on 11/19/15.
//  Copyright © 2015 Komran Ghahremani. All rights reserved.
//

import UIKit

class ListsTableViewController: UITableViewController {
    var selectedIndex = 0
    
    init() {
        super.init(style: .Plain)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "My Lists"
        
        if let tableView = tableView {
            tableView.backgroundColor = UIColor.whiteColor()
            tableView.showsVerticalScrollIndicator = false
            tableView.registerClass(ListTableViewCell.self, forCellReuseIdentifier: listCellReuseIdentifier)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
