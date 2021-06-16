//
//  ContactTableViewCell.swift
//  Contacts Navigator
//
//  Created by Bogdan Chornobryvets on 25.03.2021.
//

import UIKit

class ContactTableViewCell: UITableViewCell, ContactDetailsViewProtocol {
    @IBOutlet weak var titleCaption: UILabel!
    @IBOutlet weak var subtitleCaption: UILabel!
    @IBOutlet weak var detailsCaption: UILabel!
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    internal let activityIndicator = UIActivityIndicatorView(style: .medium)
    var viewModel: ContentViewModel?
    
}


