//
//  AppManager.swift
//  Generic-Base
//
//  Created by Ibtikar on 01/12/2022.
//

import UIKit

final class AppManager {
    
    static var shared: AppManager = AppManager()
    private(set) var window: UIWindow?
    
    private init() {
    }
    
    func initWindow(_ window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)) {
        self.window = window
        window?.rootViewController = SceneContainer.embedVCInNavController(SceneContainer.getPreviewVc())
        window?.makeKeyAndVisible()
        
    }
    
    func setRootView(viewController: UIViewController) {
        window?.rootViewController = viewController
        
    }
}
