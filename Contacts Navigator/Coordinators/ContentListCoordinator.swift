//
//  ContentListCoordinator.swift
//  Contacts Navigator
//
//  Created by Bogdan Chornobryvets on 16.06.2021.
//

import Foundation
import UIKit

class ContentListCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    var contentViewModelFabric: ContentViewModelFabric
    
    init(navigationController : UINavigationController, contentViewModelFabric: ContentViewModelFabric) {
        self.navigationController = navigationController
        self.contentViewModelFabric = contentViewModelFabric
    }
    
    func start() {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let contactsListViewController = storyboard.instantiateViewController(identifier: "ContactsListViewController") as! ContactsTableViewController
        
        var contentListViewModel = contentViewModelFabric.contentListViewModel
        contentListViewModel.contentListCoordinatorDelegate = self
        contactsListViewController.viewModel = contentListViewModel
        
        navigationController.pushViewController(contactsListViewController, animated: false)
    }
    

}

extension ContentListCoordinator: ContentListCoordinatorDelegate {
    func contentViewModel(for model: ContentModel) -> ContentViewModel {
        return contentViewModelFabric.contentListCellViewModel(for: model)
    }
    
    func listItemDidSelect(with model: ContentModel) {
        let detailsViewModel = contentViewModelFabric.detailsViewModel(for: model)
        let contentDetailsCoordinator = ContentDetailsCoordinator(navigationController: navigationController, detailsViewModel: detailsViewModel)
        contentDetailsCoordinator.start()
    }
}
