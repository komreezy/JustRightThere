//
//  CustomAnnotation.swift
//  Just Right There
//
//  Created by Komran Ghahremani on 5/13/15.
//  Copyright (c) 2015 JustRightThere. All rights reserved.
//

import UIKit
import MapKit

class CustomAnnotation : NSObject, MKAnnotation {

    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String){
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }

    func annotationView() -> MKAnnotationView{
        
        let annotationView: MKAnnotationView = MKAnnotationView(annotation: self, reuseIdentifier: "MyCustomAnnotationView")
        annotationView.enabled = true
        annotationView.canShowCallout = true
        annotationView.image = UIImage(named: "parking")
        
        return annotationView
    }
}
