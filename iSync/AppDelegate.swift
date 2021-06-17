//
//  AppDelegate.swift
//  iSync
//
//  Created by Lucky on 05/31/21.
//

import UIKit
import iOS_Slide_Menu
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.previousNextDisplayMode = .alwaysHide
        if #available(iOS 13.0, *) {
            IQKeyboardManager.shared.toolbarTintColor = .label
        } else {
            // Fallback on earlier versions
        }
        
        let menuVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MenuVC")
        
        SlideNavigationController.sharedInstance().leftMenu = menuVC
        SlideNavigationController.sharedInstance().portraitSlideOffset = g_sizeScreen.width - 240
        SlideNavigationController.sharedInstance()?.enableShadow = true
        SlideNavigationController.sharedInstance()?.enableSwipeGesture = true

        return true
    }



}

