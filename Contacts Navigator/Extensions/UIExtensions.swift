//
//  UIExtensions.swift
//  Contacts Navigator
//
//  Created by Bogdan Chornobryvets on 25.03.2021.
//

import Foundation
import UIKit

extension UIImage {
    func resized(to size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
