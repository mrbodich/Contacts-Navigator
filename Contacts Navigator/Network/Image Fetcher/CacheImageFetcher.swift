//
//  CacheImageFetcher.swift
//  Contacts Navigator
//
//  Created by Bogdan Chornobryvets on 16.06.2021.
//

import Foundation
import UIKit

class CacheImageFetcher: ImageFetcher, ImageCacher {
    
    private let lock = NSLock()
    private let cache = NSCache<NSString, UIImage>()
    
    init() {
        cache.totalCostLimit = 200 * 1024 * 1024 //200 MB
    }
    
    func fetchImage(for id: String, fetchedImage: @escaping (UIImage?) -> ()) {
        let queue = DispatchQueue(label: "com.ImageFetch.Cache", qos: .background)
        queue.async { [weak self] in
            guard let self = self else {
                fetchedImage(nil)
                return
            }
            let image = self.cache.object(forKey: NSString(string: id))
            if image != nil { print("Retrieved Cached Image") }
            DispatchQueue.main.async {
                fetchedImage(image)
            }
        }
    }
    
    func cacheImage(_ image: UIImage, for id: String) {
        lock.lock()
        defer { lock.unlock() }
        
        cache.setObject(image, forKey: NSString(string: id))
    }
}
