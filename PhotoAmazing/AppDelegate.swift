//
//  AppDelegate.swift
//  PhotoAmazing
//
//  Created by Nguyen Manh Tuan on 9/18/16.
//  Copyright © 2016 Nguyen Manh Tuan. All rights reserved.
//

import UIKit
import FBSDKCoreKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        return true
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(application, openURL: url, sourceApplication: sourceApplication, annotation: annotation)
    }
    

    func applicationWillResignActive(application: UIApplication) {
       
    }

    func applicationDidEnterBackground(application: UIApplication) {
          }

    func applicationWillEnterForeground(application: UIApplication) {
       
    }

    func applicationDidBecomeActive(application: UIApplication) {
       FBSDKAppEvents.activateApp()
    }

    func applicationWillTerminate(application: UIApplication) {
        
    }


}

