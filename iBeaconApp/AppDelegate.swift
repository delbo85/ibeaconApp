//
//  AppDelegate.swift
//  iBeaconApp
//
//  Created by Mikkel Delbo Larsen on 21/09/2016.
//  Copyright © 2016 Mikkel Delbo Larsen. All rights reserved.
//

import UIKit
import UserNotifications
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate  {

    var window: UIWindow?
    var locationManager: CLLocationManager?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: { granted, error in
            // handle error if there is one
        })
        let answerOne = UNNotificationAction(identifier: "answerOne", title: "Burger", options: [.foreground])
        let answerTwo = UNNotificationAction(identifier: "answerTwo", title: "Fries", options: [.foreground])
        let clue = UNNotificationAction(identifier: "clue", title: "See other offers", options: [.foreground])
        
        let quizCategory = UNNotificationCategory(identifier: "quizCategory", actions: [answerOne, answerTwo, clue], intentIdentifiers: [], options: [])
        UNUserNotificationCenter.current().setNotificationCategories([quizCategory])
        return true
        
        //application.registerUserNotificationSettings(UNNotificationSettings(types: [.alert, .badge, .sound], categories: nil))
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
