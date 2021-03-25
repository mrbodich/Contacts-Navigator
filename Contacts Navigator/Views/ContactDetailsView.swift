//
//  ContactDetailsView.swift
//  Contacts Navigator
//
//  Created by Bogdan Chornobryvets on 25.03.2021.
//

import UIKit

class ContactDetailsView: UIViewController, ContactDetailsViewProtocol {
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    internal let activityIndicator = UIActivityIndicatorView(style: .medium)
    weak var viewModel: ContactViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let viewModel = viewModel else { return }
        setup(with: viewModel)
    }
    
    deinit {
        viewModel?.removeFromModel()
    }

}
