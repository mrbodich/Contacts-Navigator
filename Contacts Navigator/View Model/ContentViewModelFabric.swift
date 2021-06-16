//
//  ContentViewModelFabric.swift
//  Contacts Navigator
//
//  Created by Bogdan Chornobryvets on 16.06.2021.
//

import Foundation

protocol ContentViewModelFabric {
    var contentListViewModel: ContentListViewModel { get }
    func detailsViewModel(for model: ContentModel) -> ContentViewModel
    func contentListCellViewModel(for model: ContentModel) -> ContentViewModel
}

class ContactsViewModelFabric: ContentViewModelFabric {
    var imageFetcher: ImageFetcher
    
    init() {
        let cacheFetcher = CacheImageFetcher()
        let networkFetcher = NetworkImageFetcher(imageSize: 5000, cacher: cacheFetcher)
        
        imageFetcher = cacheFetcher.retry(relief: networkFetcher)
    }
    
    var contentListViewModel: ContentListViewModel {
        let contactsListViewModel = ContactsListViewModel()
        let contentFetcher = ContactsNetworkFetcher(contactsCount: 50)
        contactsListViewModel.model = ContactsListModel(contentFetcher: contentFetcher)
        return contactsListViewModel
    }
    func detailsViewModel(for model: ContentModel) -> ContentViewModel {
        return ContactDetailsViewModel(model: model, imageFetcher: imageFetcher, imageSize: 300)
    }
    func contentListCellViewModel(for model: ContentModel) -> ContentViewModel {
        return ContactDetailsViewModel(model: model, imageFetcher: imageFetcher, imageSize: 80)
    }
    
}
