//
//  ContentDetailsCoordinator.swift
//  Contacts Navigator
//
//  Created by Bogdan Chornobryvets on 16.06.2021.
//

import Foundation
import UIKit

class ContentDetailsCoordinator: Coordinator {
    
    let navigationController: UINavigationController
    var detailsViewModel: ContentViewModel
    
    init(navigationController: UINavigationController, detailsViewModel: ContentViewModel) {
        self.navigationController = navigationController
        self.detailsViewModel = detailsViewModel
    }
    
    func start() {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        
        let contactsDetailsViewController = storyboard.instantiateViewController(identifier: "ContactDetailsViewController") as! ContactDetailsView
        
        contactsDetailsViewController.viewModel = detailsViewModel
        
        navigationController.present(contactsDetailsViewController, animated: true)
    }
    
}
