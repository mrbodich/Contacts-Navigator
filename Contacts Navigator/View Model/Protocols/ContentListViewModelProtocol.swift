//
//  ContentListViewModelProtocol.swift
//  Contacts Navigator
//
//  Created by Bogdan Chornobryvets on 16.06.2021.
//

import Foundation

protocol ContentListViewModel {
    var model: ContentListModel? { get set }
    var contentListCoordinatorDelegate: ContentListCoordinatorDelegate? { get set }
    var contentListViewDelegate: ContentListViewDelegate? { get set }
    
    var itemsCount: Int { get }
    func itemAtIndex(_: Int) -> ContentViewModel?
    func selectItemAt(index: Int)
}

protocol ContentListCoordinatorDelegate: AnyObject {
    func contentViewModel(for model: ContentModel) -> ContentViewModel
    func listItemDidSelect(with model: ContentModel)
}

protocol ContentListViewDelegate: AnyObject {
    func contentDidChange()
}
