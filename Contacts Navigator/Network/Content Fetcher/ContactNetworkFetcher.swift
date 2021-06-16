//
//  ContactNetworkFetcher.swift
//  Contacts Navigator
//
//  Created by Bogdan Chornobryvets on 16.06.2021.
//

import Foundation

class ContactsNetworkFetcher: ContentFetcher {
    private var fetchedContacts: [RandomUserContact]?
    private var contactsIsBeingFetching = false
    
    private let randomUsersURL = "https://randomuser.me/api/?results="
    private let targetContactsCount: Int
    
    init(contactsCount: Int) {
        targetContactsCount = contactsCount
    }
    
    func fetchContentList(_ completion: @escaping ([ContentModel]) -> ()) {
        fetchContacts { contacts in
            let contactModels: [ContactModel] = contacts.map { contact in
                let contactModel = ContactModel(id: UUID().uuidString,
                                                firstName: contact.firstName,
                                                lastName: contact.lastName,
                                                email: contact.email)
                return contactModel
            }
            completion(contactModels)
        }
    }
    
    private func fetchContacts(completionHandler: @escaping (_ contacts: [RandomUserContact]) -> ()) {
        if let contacts = self.fetchedContacts {
            completionHandler(contacts)
            return
        } else  {
            if !contactsIsBeingFetching {
                fetchRandomContacts { contacts in
                    completionHandler(contacts)
                }
            }
        }
        
    }
    
    private func fetchRandomContacts(completionHandler: @escaping (_ contacts: [RandomUserContact]) -> ()) {
        guard let url = URL(string: "\(randomUsersURL)\(targetContactsCount)") else { return }
        let request = URLRequest(url: url)
        let urlSession = URLSession.shared.dataTask(with: request) { data, response, error in
            self.contactsIsBeingFetching = false
            if let error = error {
                print("‼️ Fetching users failed with error: \(error.localizedDescription)")
                return
            }
            let decoder = JSONDecoder()
            guard let data = data, let fetchedUsers = try? decoder.decode(RandomUserResults.self, from: data) else {
                print("‼️ Decoding users from JSON failed")
                return
            }
            
            self.fetchedContacts = fetchedUsers.results
            completionHandler(fetchedUsers.results)
        }
        self.contactsIsBeingFetching = true
        urlSession.resume()
    }
    
    private struct RandomUserResults: Decodable {
        let results: [RandomUserContact]
    }
}

fileprivate struct RandomUserContact: Decodable {

    let firstName: String
    let lastName: String
    let email: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case email
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let name = try container.decode(ContactName.self, forKey: .name)
        firstName = name.first
        lastName = name.last
        self.email = try container.decode(String.self, forKey: .email)
    }
    
    struct ContactName: Decodable {
        let first: String
        let last: String
    }
}

