//
//  Contact.swift
//  Contacts Navigator
//
//  Created by Bogdan Chornobryvets on 25.03.2021.
//

import Foundation
import UIKit

protocol ContentModel {
    var id: String { get }
    var title: String { get }
    var subTitle: String { get }
    var details: String { get }
}

class ContactModel: ContentModel {
    let id: String
    let title: String
    let subTitle: String
    let details: String
    
    init(id: String, firstName: String, lastName: String, email: String) {
        self.id = id
        self.title = firstName
        self.subTitle = lastName
        self.details = email
    }
    
    
}


