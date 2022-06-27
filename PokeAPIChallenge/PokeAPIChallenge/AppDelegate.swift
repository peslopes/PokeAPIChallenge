//
//  AppDelegate.swift
//  PokeAPIChallenge
//
//  Created by Pedro Sobrosa on 26/06/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow()
        let viewController = MainSceneFactory.make()
        let navigation = UINavigationController(rootViewController: viewController)
        
        window.rootViewController = navigation
        
        window.makeKeyAndVisible()
        self.window = window

        return true
    }
}

