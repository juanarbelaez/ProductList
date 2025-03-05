//
//  AppDelegate.swift
//  ProductList
//
//  Created by Juan Arbelaez on 3/03/25.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    let productListView = ProductListView()
    let productDetailView = ProductDetailView()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        
//        window?.rootViewController = productDetailView
        let navigationController = UINavigationController(rootViewController: productListView)
        window?.rootViewController = navigationController

        navigationController.navigationBar.prefersLargeTitles = true
        
        return true
    }

}

