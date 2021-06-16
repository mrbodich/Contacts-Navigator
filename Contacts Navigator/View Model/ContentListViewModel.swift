//
//  ContentListViewModel.swift
//  Contacts Navigator
//
//  Created by Bogdan Chornobryvets on 16.06.2021.
//

import Foundation

class ContactsListViewModel: ContentListViewModel {
    weak var contentListCoordinatorDelegate: ContentListCoordinatorDelegate?
    weak var contentListViewDelegate: ContentListViewDelegate?
    
    var model: ContentListModel? {
        didSet {
            items = []
            model?.listItems({ [weak self] items in
                guard let self = self, let coordinator = self.contentListCoordinatorDelegate else { return }
                self.items = items.map{ model in
                    coordinator.contentViewModel(for: model)
                }
            })
        }
    }
    
    private var items: [ContentViewModel] = [] {
        didSet {
            contentListViewDelegate?.contentDidChange()
        }
    }
    
    var itemsCount: Int {
        return items.count
    }
    
    func itemAtIndex(_ index: Int) -> ContentViewModel? {
        if items.count > index {
            return items[index]
        }
        return nil
    }
    
    func selectItemAt(index: Int) {
        contentListCoordinatorDelegate?.listItemDidSelect(with: items[index].model)
    }
}
