//
//  Contact.swift
//  Contacts Navigator
//
//  Created by Bogdan Chornobryvets on 25.03.2021.
//

import Foundation
import UIKit

class Contact: Decodable, CustomStringConvertible {

    let firstName: String
    let lastName: String
    let email: String
    var picture: UIImage? {
        didSet {
            for viewModel in viewModels.values {
                viewModel.setPicture(picture)
                viewModel.pictureDidChange?()
            }
        }
    }
    var viewModels: [String: ContactViewModel] = [:]
    
    enum CodingKeys: String, CodingKey {
        case name
        case email
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let name = try container.decode(ContactName.self, forKey: .name)
        firstName = name.first
        lastName = name.last
        self.email = try container.decode(String.self, forKey: .email)
    }
    
    init(firstName: String, lastName: String, email: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
    }
    
    convenience init(firstName: String, lastName: String, email: String, picture: UIImage) {
        self.init(firstName: firstName, lastName: lastName, email: email)
        self.picture = picture
    }
    
    var description: String {
        return "First name: \(firstName), Last name: \(lastName), email: \(email), picture \(picture == nil ? "❌" : "✅")"
    }
}

struct ContactName: Decodable {
    let first: String
    let last: String
}

class ContactViewModel {
    let id: String
    let firstName: String
    let lastName: String
    let email: String
    var picture: UIImage?
    var pictureDidChange: (() -> ())?
    weak var contact: Contact?
    
    init(from contact: Contact) {
        id = UUID().uuidString
        firstName = contact.firstName
        lastName = contact.lastName
        email = contact.email
        setPicture(contact.picture)
        self.contact = contact
        contact.viewModels[id] = self
    }
    
    func setPicture(_ picture: UIImage?) {
        self.picture = picture?.resized(to: CGSize(width: 200, height: 200))
    }
    
    func removeFromModel() {
        contact?.viewModels.removeValue(forKey: id)
        pictureDidChange = nil
    }
    
    deinit {
        print("ContactViewModel deinited")
    }
    
}
