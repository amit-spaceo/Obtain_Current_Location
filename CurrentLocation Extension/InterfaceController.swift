//
//  InterfaceController.swift
//  CurrentLocation Extension
//
//  Created by SOTSYS122 on 30/03/17.
//  Copyright © 2017 SOTSYS122. All rights reserved.
//

import WatchKit
import Foundation
import CoreLocation


class InterfaceController: WKInterfaceController{

    @IBOutlet var mapView: WKInterfaceMap!
    @IBOutlet var lblLatitude: WKInterfaceLabel!
    @IBOutlet var lbllongitude: WKInterfaceLabel!
    
    var currentLocation = CLLocation()
    var lat:Double = 0.0
    var long:Double = 0.0
    
    //MARK:- Lifecycle -
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        WatchConnector.shared.listenToMessageBlock({ (message) in
            
            self.lat = message["lat"] as! Double
            self.long = message["long"] as! Double
            print(self.lat)
            print(self.long)
            
             self.currentLocation = CLLocation(latitude: self.lat as! CLLocationDegrees, longitude: self.long as! CLLocationDegrees)
            
            let mylocation : CLLocationCoordinate2D = CLLocationCoordinate2DMake(self.currentLocation.coordinate.latitude, self.currentLocation.coordinate.longitude)
            let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
            let region = MKCoordinateRegion(center: mylocation, span: span)
            self.mapView.setRegion(region)
            self.mapView.addAnnotation(mylocation, with: .red)
        }, withIdentifier: "sendCurrentLocation")
        
        
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    //MARK:- Button Action -
    @IBAction func btnGetCurrentLocationClicked() {
        self.lblLatitude.setText("\(self.lat)")
        self.lbllongitude.setText("\(self.long)")
    }    
}
