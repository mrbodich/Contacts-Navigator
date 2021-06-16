//
//  ContentViewModelProtocol.swift
//  Contacts Navigator
//
//  Created by Bogdan Chornobryvets on 16.06.2021.
//

import Foundation
import UIKit

protocol ContentViewModel {
    
    var model: ContentModel { get }
    
    var imageSize: CGFloat { get }
    
    var titleCaption: String { get }
    var subtitleCaption: String { get }
    var detailsCaption: String { get }
    
    var title: String { get }
    var subtitle: String { get }
    var details: String { get }
    
    func getImage(_: @escaping (_ image: UIImage?) -> ())
}
