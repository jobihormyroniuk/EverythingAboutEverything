//
//  AUIApplication.swift
//  AUIKit
//
//  Created by Ihor Myroniuk on 5/24/19.
//

import UIKit

open class AUIEmptyApplication: UIApplication, AUIApplication {
 
    // MAKR: Initializer
  
    public override init() {
        super.init()
        setup()
    }
  
    // MARK: Setup
  
    open func setup() {
        
    }
  
    // MARK: Window
  
    open var window: UIWindow?
  
    // MARK: Launching
  
    open func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        if launchOptions?[UIApplication.LaunchOptionsKey.location] != nil {
            willFinishLaunchingLocation()
            return true
        }
        if let payload = launchOptions?[UIApplication.LaunchOptionsKey.remoteNotification] as? [AnyHashable: Any] {
            willFinishLaunchingNotification(payload: payload)
            return true
        }
        if let shortcutItem = launchOptions?[UIApplication.LaunchOptionsKey.shortcutItem] as? UIApplicationShortcutItem {
            willFinishLaunchingShortcutItem(shortcutItem)
            return true
        }
        willFinishLaunching()
        return true
    }
  
    open func willFinishLaunching() {
        
    }
  
    open func willFinishLaunchingNotification(payload: [AnyHashable : Any]) {
        
    }
  
    open func willFinishLaunchingLocation() {
        
    }
  
    open func willFinishLaunchingShortcutItem(_ shortcutItem: UIApplicationShortcutItem) {
        
    }

    open func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        if launchOptions?[UIApplication.LaunchOptionsKey.location] != nil {
            didFinishLaunchingLocation()
            return true
        }
        if let payload = launchOptions?[UIApplication.LaunchOptionsKey.remoteNotification] as? [AnyHashable: Any] {
            didFinishLaunchingNotification(payload: payload)
            return true
        }
        if let shortcutItem = launchOptions?[UIApplication.LaunchOptionsKey.shortcutItem] as? UIApplicationShortcutItem {
            didFinishLaunchingShortcutItem(shortcutItem)
            return true
        }
        didFinishLaunching()
        print(UUID().uuidString)
        return true
    }
  
    open func didFinishLaunching() {
        
    }
  
    open func didFinishLaunchingNotification(payload: [AnyHashable : Any]) {
        
    }
  
    open func didFinishLaunchingLocation() {
        
    }
  
    open func didFinishLaunchingShortcutItem(_ shortcutItem: UIApplicationShortcutItem) {
        
    }

    // MARK: States
  
    open func applicationWillEnterForeground(_ application: UIApplication) {
        willEnterForeground()
    }
  
    open func willEnterForeground() {
    
    }
  
    open func applicationDidBecomeActive(_ application: UIApplication) {
        didBecomeActive()
    }
  
    open func didBecomeActive() {
        
    }
  
    open func applicationWillResignActive(_ application: UIApplication) {
        willResignActive()
    }
  
    open func willResignActive() {
        
    }
  
    open func applicationDidEnterBackground(_ application: UIApplication) {
        didEnterBackground()
    }
  
    open func didEnterBackground() {
        
    }
  
    open func applicationWillTerminate(_ application: UIApplication) {
        willTerminate()
    }
  
    open func willTerminate() {
        
    }
  
    // MARK: Memory
  
    open func applicationDidReceiveMemoryWarning(_ application: UIApplication) {
        didReceiveMemoryWarning()
    }
  
    open func didReceiveMemoryWarning() {
    
    }
  
    // MARK: Remote Notifications
  
    open func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        didRegisterForRemoteNotificationsWithDeviceToken(deviceToken)
    }
  
    open func didRegisterForRemoteNotificationsWithDeviceToken(_ deviceToken: Data) {
        
    }
  
    open func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        didFailToRegisterForRemoteNotificationsWithError(error)
    }
  
    open func didFailToRegisterForRemoteNotificationsWithError(_ error: Error) {
        
    }
  
    open func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        didReceiveRemoteNotification(userInfo: userInfo, fetchCompletionHandler: completionHandler)
    }
  
    open func didReceiveRemoteNotification(userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
    }
    
}
