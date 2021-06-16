//
//  ContactDetailsViewProtocol.swift
//  Contacts Navigator
//
//  Created by Bogdan Chornobryvets on 16.06.2021.
//

import Foundation
import UIKit

protocol ContactDetailsViewProtocol: AnyObject {
    var titleCaption: UILabel! { get set }
    var subtitleCaption: UILabel! { get set }
    var detailsCaption: UILabel! { get set }
    
    var titleLabel: UILabel! { get set }
    var subtitleLabel: UILabel! { get set }
    var detailsLabel: UILabel! { get set }
    var avatarImageView: UIImageView! { get set }
    var activityIndicator: UIActivityIndicatorView { get }
    var viewModel: ContentViewModel? { get set }
}

extension ContactDetailsViewProtocol {
    func setup(with model: ContentViewModel) {
        viewModel = model
        avatarImageView.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: avatarImageView.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor).isActive = true
        activityIndicator.stopAnimating()
        
        titleCaption.text = "\(model.titleCaption):"
        subtitleCaption.text = "\(model.subtitleCaption):"
        detailsCaption.text = "\(model.detailsCaption):"
        
        titleLabel.text = model.title
        subtitleLabel.text = model.subtitle
        detailsLabel.text = model.details
        
        setAvatarImage()
        viewModel?.getImage { [weak self] image in
            if self?.viewModel?.model.id == model.model.id {
                print("Setting UIImage to the cell")
                self?.setAvatarImage(image: image)
            } else {
                print("Skipping UIImage set")
            }
        }
    }
    
    private func setAvatarImage(image: UIImage? = nil) {
        avatarImageView.image = image
        if image == nil {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
}
