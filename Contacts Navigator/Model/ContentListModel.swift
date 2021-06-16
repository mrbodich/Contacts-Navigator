//
//  ContentListModel.swift
//  Contacts Navigator
//
//  Created by Bogdan Chornobryvets on 16.06.2021.
//

import Foundation

protocol ContentListModel {
    var contentFetcher: ContentFetcher { get set }
    func listItems(_ completionHandler: @escaping (_ items: [ContentModel]) -> ())
    
}

class ContactsListModel: ContentListModel {
    var contentFetcher: ContentFetcher
    var contentList: [ContentModel] = []
    
    init(contentFetcher: ContentFetcher) {
        self.contentFetcher = contentFetcher
    }
    
    func listItems(_ completionHandler: @escaping (_ contacts: [ContentModel]) -> ()) {
        contentFetcher.fetchContentList { content in
            DispatchQueue.main.async {
                completionHandler(content)
            }
        }
    }
}
