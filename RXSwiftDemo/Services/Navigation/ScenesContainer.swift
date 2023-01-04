//
//  ScenesContainer.swift
//  Generic-Base
//
//  Created by Ibtikar on 01/12/2022.
//

import UIKit

final class AppNavigationController: UINavigationController {}

final class SceneContainer {
    
    class func embedVCInNavController(_ viewController: UIViewController) -> UIViewController {
        let nav = AppNavigationController(rootViewController: viewController)
        return nav
    }
    class func getMenuTabsVC() -> MenuTabsVC {
        MenuTabsVC()
    }
    class func getHomeScreen() -> HomeVC {
        HomeVC()
    }
    
    class func getVerification() -> VerificationVC {
        VerificationVC()
    }
}
