//
//  Contact.swift
//  Contacts Navigator
//
//  Created by Bogdan Chornobryvets on 25.03.2021.
//

import Foundation
import UIKit

class Contact: NSObject, Decodable {

    let firstName: String
    let lastName: String
    let email: String
    @objc dynamic var picture: UIImage?
    
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
    
    override var description: String {
        return "First name: \(firstName), Last name: \(lastName), email: \(email), picture \(picture == nil ? "❌" : "✅")"
    }
}

struct ContactName: Decodable {
    let first: String
    let last: String
}
