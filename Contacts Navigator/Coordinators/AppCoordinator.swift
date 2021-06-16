//
//  AppCoordinator.swift
//  Contacts Navigator
//
//  Created by Bogdan Chornobryvets on 16.06.2021.
//

import Foundation
import UIKit

class AppCoordinator: Coordinator {
    let window: UIWindow
    var listCoordinator: ContentListCoordinator!
    
    init(window : UIWindow) {
        self.window = window
    }
    
    func start() {
        showList()
    }
    
    func showList() {
        let navController = UINavigationController()
        window.rootViewController = navController
        
        
        let contentViewModelFabric = ContactsViewModelFabric()
        listCoordinator = ContentListCoordinator(navigationController: navController, contentViewModelFabric: contentViewModelFabric)
        listCoordinator.start()
    }
}
