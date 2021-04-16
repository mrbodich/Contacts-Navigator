//
//  ContactViewModel.swift
//  Contacts Navigator
//
//  Created by Bogdan Chornobryvets on 16.04.2021.
//

import UIKit

class ContactViewModel: NSObject {
    let id: String
    let firstName: String
    let lastName: String
    let email: String
    var picture: UIImage?
    var pictureDidChange: (() -> ())?
    let pictureSize: CGFloat?
    @objc var contact: Contact?
    var observation: NSKeyValueObservation?
    
    init(from contact: Contact, pictureSize: CGFloat? = nil) {
        id = UUID().uuidString
        firstName = contact.firstName
        lastName = contact.lastName
        email = contact.email
        self.pictureSize = pictureSize
        super.init()
        setPicture(contact.picture)
        self.contact = contact
        
        observation = contact.observe(\.picture, options: [.new], changeHandler: { [weak self] object, change in
            guard let picture = change.newValue else { return }

            self?.setPicture(picture)
        })
    }
    
    func setPicture(_ picture: UIImage?) {
        DispatchQueue.global(qos: .utility).async { [weak self] in
            guard let self = self else { return }
            if let pictureSize = self.pictureSize {
                self.picture = picture?.resized(to: CGSize(width: pictureSize, height: pictureSize))
            } else {
                self.picture = picture
            }
            self.pictureDidChange?()
        }
    }
    
    deinit {
        observation?.invalidate()
        print("ContactViewModel deinited")
    }
    
}
