//
//  NetworkManager.swift
//  Contacts Navigator
//
//  Created by Bogdan Chornobryvets on 25.03.2021.
//

import Foundation
import UIKit

final class NetworkManager {
    private let randomUsersURL = "https://randomuser.me/api/?results="
    private let randomImageURL = "https://picsum.photos/"
    private var contactsSubscribers: [String: (_ contacts: [Contact]) -> ()] = [:]
    private var fetchedContacts: [Contact]? {
        didSet {
            guard let contacts = fetchedContacts else { return }
            let subscriberCallbacks = contactsSubscribers.values
            contactsSubscribers.removeAll()
            for subscriberCallback in subscriberCallbacks {
                subscriberCallback(contacts)
            }
            for contact in contacts {
                fetchRandomImage { image in
                    contact.picture = image
                }
            }
        }
    }
    private var contactsIsBeingFetching = false
    private let targetContactsCount: Int = 10

    static let `default` = NetworkManager()
    private init() {}
    
    private lazy var operationQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 4
        return queue
    }()
    
    func fetchRandomImage(completionHandler: @escaping (_ image: UIImage) -> ()) {
        let fetchOperation = RandomImageFetchingOperation(urlString: randomImageURL) { image in
            completionHandler(image)
        }
        operationQueue.addOperation(fetchOperation)
    }
    
    func fetchContacts(completionHandler: @escaping (_ contacts: [Contact]) -> ()) {
        if let contacts = self.fetchedContacts {
            completionHandler(contacts)
            return
        } else  {
            let subscriberID = UUID().uuidString
            contactsSubscribers[subscriberID] = completionHandler
            if !contactsIsBeingFetching {
                fetchRandomContacts()
            }
        }
        
    }
    
    func fetchRandomContacts() {
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
            for contact in fetchedUsers.results {
                print(contact)
            }
        }
        self.contactsIsBeingFetching = true
        urlSession.resume()
    }
}

fileprivate struct RandomUserResults: Decodable {
    let results: [Contact]
}
