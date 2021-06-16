//
//  ContentFetcher.swift
//  Contacts Navigator
//
//  Created by Bogdan Chornobryvets on 16.06.2021.
//

import Foundation

protocol ContentFetcher {
    func fetchContentList(_ completion: @escaping (_ content: [ContentModel]) -> ())
}

class ContactsLocalFetcher: ContentFetcher {
    
    func fetchContentList(_ completion: @escaping (_ content: [ContentModel]) -> ()) {
        var contentList: [ContactModel] = []
        contentList.append(ContactModel(id: "0", firstName: "Serg", lastName: "Brown", email: "serg.brown@gmail.com"))
        contentList.append(ContactModel(id: "0", firstName: "Mary", lastName: "Laura", email: "mary@gmail.com"))
        contentList.append(ContactModel(id: "0", firstName: "Gary", lastName: "Solarus", email: "solarus@gmail.com"))
        contentList.append(ContactModel(id: "0", firstName: "Richard", lastName: "Lipstigh", email: "rlipstigh@gmail.com"))
        contentList.append(ContactModel(id: "0", firstName: "Paul", lastName: "Born", email: "paul12345@gmail.com"))
        contentList.append(ContactModel(id: "0", firstName: "Prometheus", lastName: "Calin", email: "prom.calin@gmail.com"))
        
        completion(contentList)
    }
}

