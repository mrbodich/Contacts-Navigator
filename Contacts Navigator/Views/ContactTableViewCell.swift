//
//  ContactTableViewCell.swift
//  Contacts Navigator
//
//  Created by Bogdan Chornobryvets on 25.03.2021.
//

import UIKit

class ContactTableViewCell: UITableViewCell, ContactDetailsViewProtocol {
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    internal let activityIndicator = UIActivityIndicatorView(style: .medium)
    var viewModel: ContactViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

protocol ContactDetailsViewProtocol: class {
    var firstNameLabel: UILabel! { get set }
    var lastNameLabel: UILabel! { get set }
    var emailLabel: UILabel! { get set }
    var avatarImageView: UIImageView! { get set }
    var activityIndicator: UIActivityIndicatorView { get }
    var viewModel: ContactViewModel? { get set }
}

extension ContactDetailsViewProtocol {
    func setup(with model: ContactViewModel) {
        viewModel = model
        avatarImageView.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: avatarImageView.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor).isActive = true
        activityIndicator.stopAnimating()
        
        firstNameLabel.text = model.firstName
        lastNameLabel.text = model.lastName
        emailLabel.text = model.email
        setAvatarImage(image: model.picture)
        model.pictureDidChange = { [weak self, weak model] in
            DispatchQueue.main.async {
                self?.setAvatarImage(image: model?.picture)
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
