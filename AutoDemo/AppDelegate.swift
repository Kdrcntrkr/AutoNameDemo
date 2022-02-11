//
//  AppDelegate.swift
//  AutoDemo
//
//  Created by Kadircan Türker on 19.09.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    internal var window: UIWindow?
    internal var appCoordinator: Coordinator?
    
    var isRunningTests: Bool {
        return ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let navigationController = UINavigationController()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        if isRunningTests { return true }
        appCoordinator = AppCoordinator(navigationController: navigationController)
        appCoordinator?.start()
        return true
    }


}

