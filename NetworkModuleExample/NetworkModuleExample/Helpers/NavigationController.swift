//
//  NavigationController.swift
//  NetworkModuleExample
//
//  Created by Aklesh on 16/11/21.
//

import Foundation
import UIKit

class NavigationController: UINavigationController {
    
    // MARK: - Override
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        self.navigationBar.isTranslucent = false
        self.navigationBar.barTintColor = UIColor.themeColor
        
        let navFont = UIFont.systemFont(ofSize: 18.0, weight: UIFont.Weight.bold)
        let navBarAttributesDictionary: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: navFont ]
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.themeColor
        appearance.titleTextAttributes = navBarAttributesDictionary
        navigationBar.standardAppearance = appearance;
        navigationBar.scrollEdgeAppearance = navigationBar.standardAppearance        
    }
}
