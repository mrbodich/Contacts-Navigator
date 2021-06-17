//
//  NetworkImageFetcher.swift
//  Contacts Navigator
//
//  Created by Bogdan Chornobryvets on 16.06.2021.
//

import Foundation
import UIKit

class NetworkImageFetcher: ImageFetcher {
    private let imageSize: Int
    private let semaphore = DispatchSemaphore(value: 4)
    private let randomImageURLString = "https://picsum.photos/"
    private let imageCacher: ImageCacher
    
    typealias CompletionHandler = (UIImage?) -> ()
    private var awaitingSubscribers: [String: [CompletionHandler]] = [:]
    
    init(imageSize: Int, cacher: ImageCacher) {
        self.imageSize = imageSize
        imageCacher = cacher
    }
    
    func fetchImage(for id: String, fetchedImage: @escaping CompletionHandler) {
        let isIdFetching = awaitingSubscribers[id] != nil
        awaitingSubscribers[id, default: []].append(fetchedImage)
        if isIdFetching { return }
        
        guard let imageUrl = URL(string: randomImageURLString)?.appendingPathComponent("\(imageSize)") else { return }
        var image: UIImage?
        let queue = DispatchQueue(label: "com.ImageFetch.Network", qos: .background, attributes: .concurrent)
        
        queue.async { [semaphore, imageCacher] in
            semaphore.wait()
            print("Downloading Image...")
            if let imageData = try? Data(contentsOf: imageUrl) {
                image = UIImage(data: imageData)
                if let image = image {
                    imageCacher.cacheImage(image, for: id)
                }
            }
            semaphore.signal()
            DispatchQueue.main.async { [weak self] in
                self?.awaitingSubscribers[id]?.forEach { completion in
                    completion(image)
                }
                self?.awaitingSubscribers.removeValue(forKey: id)
            }
        }
        
    }
}
