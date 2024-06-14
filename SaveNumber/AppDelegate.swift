//
//  AppDelegate.swift
//  SaveNumber
//
//  Created by Benjamin Wong on 2024/5/13.
//

import UIKit
import SwifterSwift
import RxSwift
import RxCocoa

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    _ = Client.shared.currentUser.observe(on: MainScheduler.instance).subscribe(onNext: { [weak self] user in
      guard let self = self, let user = user else {
        return
      }
      
//      self.nameLabel.text = user.name
//      if let n = user.myNumber {
//        self.textField.text = "\(n)"
//      }
    })
    return true
  }

  // MARK: UISceneSession Lifecycle

  func applicationWillEnterForeground(_ application: UIApplication) {
  }
  
  func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
  }

  func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
  }
  
  func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
    return Client.shared.handleOpen(url: url)
  }
  
  func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
    return Client.shared.handleOpen(url: url)
  }
}

