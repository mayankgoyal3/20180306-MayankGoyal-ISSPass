//
//  AppDelegate.swift
//  ISSPassTimes
//
//  Created by Mayank Goyal on 06/03/18.
//  Copyright © 2018 Mayank Goyal. All rights reserved.
//

import UIKit

var appDelegate: AppDelegate {
    return UIApplication.shared.delegate as! AppDelegate
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        return true
    }
    
    /**
     Alert for location access Denied
    */
    func showAlertForUpdateLocation() {
        let alert = UIAlertController(title: "Location Access Denied".localize(), message: "GPS access is restricted. In order to use tracking, please enable GPS in the Settigs app under Privacy, Location Services.".localize(), preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Go To Setting", style: UIAlertActionStyle.default, handler: { (alert: UIAlertAction!) in
            UIApplication.shared.openURL(NSURL(string:UIApplicationOpenSettingsURLString)! as URL)
        }))
        if let controller = self.window?.rootViewController {
            controller.present(alert, animated: true, completion: nil)
        }
    }

    /**
     function for show alert
     
     parameter: tuple(STring, String)
     */
    func simpleAlertWithTitleAndMessage(_ titleMessage: (String, String)) {
        let alert = UIAlertController(title: titleMessage.0, message: titleMessage.1, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (alert: UIAlertAction!) in
        }))
        if let controller = self.window?.rootViewController {
            controller.present(alert, animated: true, completion: nil)
        }
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

