//
//  ImageFetcher.swift
//  Contacts Navigator
//
//  Created by Bogdan Chornobryvets on 13.06.2021.
//

import Foundation
import UIKit

protocol ImageCacher {
    func cacheImage(_ image: UIImage, for id: String)
}

protocol ImageFetcher {
    func fetchImage(for id: String, fetchedImage: @escaping (UIImage?) -> ())
}

extension ImageFetcher {
    func retry(count: UInt = 1, relief: ImageFetcher) -> ImageFetcher {
        var fetcher: ImageFetcher = self
        for _ in 0..<count {
            fetcher = ImageFetcherProxy(fetcher: fetcher, reliefFetcher: relief)
        }
        return fetcher
    }
}

fileprivate class ImageFetcherProxy: ImageFetcher {
    var reliefFetcher: ImageFetcher?
    var fetcher: ImageFetcher
    
    init(fetcher: ImageFetcher, reliefFetcher: ImageFetcher) {
        self.fetcher = fetcher
        self.reliefFetcher = reliefFetcher
    }
    
    func fetchImage(for id: String, fetchedImage: @escaping (UIImage?) -> ()) {
        fetcher.fetchImage(for: id) { [reliefFetcher] image in
            if let image = image {
                fetchedImage(image)
            } else {
                reliefFetcher?.fetchImage(for: id, fetchedImage: { image in
                    fetchedImage(image)
                })
            }
        }
    }
}
