//
//  Manager.swift
//  Just Right There
//
//  Created by Komran Ghahremani on 4/4/15.
//  Copyright (c) 2015 JustRightThere. All rights reserved.
//

import UIKit
import CoreLocation

/***********************************************************************************************************************

List - a title that goes with a text field and a location
 * Each title is a String that comes from the location view controller when a user selects a place to make a list for
 * Each item list is stored as a String
 * Each Location is stored as a CLLocationCoordinate2D variable

***********************************************************************************************************************/

struct list {
    var title: String = "" //name of the place is the same as the name of the list because there is one list per place
    var location: CLLocationCoordinate2D = CLLocationCoordinate2D() //coordinates of the place have to come from the map
    var items: String = ""
}

var manager: Manager = Manager()

class Manager: NSObject {
    
    //holds all of the location lists
    var lists: [list] = [list(title:"Nike Store", location: CLLocationCoordinate2D(latitude: 80.0, longitude: 80.0), items: "Shoes")]
    var currentIndex = 0
    
    //make blank list with title and location passed in
    func addList(titleParam: String, coordinate: CLLocationCoordinate2D){
        lists.append(list(title: titleParam, location: coordinate, items: ""))
    }
}
