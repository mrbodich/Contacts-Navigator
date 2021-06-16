//
//  ContentViewModel.swift
//  Contacts Navigator
//
//  Created by Bogdan Chornobryvets on 16.06.2021.
//

import Foundation
import UIKit

class ContactDetailsViewModel: ContentViewModel {

    var titleCaption = "First Name"
    var subtitleCaption = "Second Name"
    var detailsCaption = "Email"
    
    var title: String {
        model.title
    }
    var subtitle: String {
        model.subTitle
    }
    var details: String {
        model.details
    }
    

    var model: ContentModel
    var imageSize: CGFloat
    var imageFetcher: ImageFetcher
    
    init(model: ContentModel, imageFetcher: ImageFetcher, imageSize: CGFloat) {
        self.model = model
        self.imageFetcher = imageFetcher
        self.imageSize = imageSize
    }
    
    func getImage(_ completion: @escaping (UIImage?) -> ()) {
        imageFetcher.fetchImage(for: model.id) { [imageSize] image in
            DispatchQueue.global(qos: .background).async {
                let image = image?.resized(to: CGSize(width: imageSize, height: imageSize))
                DispatchQueue.main.async {
                    completion(image)
                }
            }
        }
    }
}
