//
//  PassTimeViewController.swift
//  ISSPassTimes
//
//  Created by Mayank Goyal on 06/03/18.
//  Copyright © 2018 Mayank Goyal. All rights reserved.
//

import UIKit
import CoreLocation

class PassTimeViewController: UIViewController, CLLocationManagerDelegate {

    lazy var locationManager: CLLocationManager = {
        var _locationManager = CLLocationManager()
        _locationManager.delegate = self
        _locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        _locationManager.activityType = .automotiveNavigation
        _locationManager.distanceFilter = 3000.0  // Movement threshold for new events
        _locationManager.allowsBackgroundLocationUpdates = true // allow in background
        
        return _locationManager
    }()
    var currentLocation: CLLocation?
    
    @IBOutlet weak var tableView: UITableView!
    var passTimeData = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Function for enable the core location services
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.startUpdatingLocation()
    }
        
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        appDelegate.showAlertForUpdateLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            if self.currentLocation != location {
                self.currentLocation = location
                self.getIssPaaTime()
            }
        }
        self.locationManager.stopUpdatingLocation()
    }
    
    func getIssPaaTime() {
        if let latitude = self.currentLocation?.coordinate.latitude, let longitude = self.currentLocation?.coordinate.longitude {
            let strUrl = String(format: issPassTime, latitude , longitude)
            WebLayerManager.sharedInstance.executeService(urlPath: strUrl, httpMethodType: "GET", body: nil) { (result, error) in
                if let error = error {
                    appDelegate.simpleAlertWithTitleAndMessage(messageFromError(error))
                } else {
                    DispatchQueue.main.async {
                        if let result = result as? [String: Any] {
                            if let responseArr = result["response"] as? NSMutableArray {
                                self.passTimeData = responseArr
                            }
                        }
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }    
}
