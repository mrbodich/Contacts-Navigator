//
//  ViewController.swift
//  Contacts Navigator
//
//  Created by Bogdan Chornobryvets on 25.03.2021.
//

import UIKit

class ContactsTableViewController: UITableViewController {
    
    var viewModel: ContentListViewModel? {
        willSet {
            viewModel?.contentListViewDelegate = nil
        }
        didSet {
            viewModel?.contentListViewDelegate = self
            refreshTable()
        }
    }
    
//    var contacts: [Contact] = [] {
//        didSet {
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
//        }
//    }
    
    private func refreshTable() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "ContactTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "ContactCell")
        
        self.tableView.estimatedRowHeight = 44.0
        self.tableView.rowHeight = UITableView.automaticDimension
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.itemsCount ?? 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell") as! ContactTableViewCell
        
//        let tempViewModel = ContactViewModel(from: Contact(firstName: "Greg", lastName: "Johnson", email: "greg@gmail.com"), pictureSize: 200)
        let cellViewModel = viewModel?.itemAtIndex(indexPath.row)
        cell.setup(with: cellViewModel!)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        performSegue(withIdentifier: "ShowContactDetails", sender: contacts[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel?.selectItemAt(index: indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard let detailsController = segue.destination as? ContactDetailsView, let contact = sender as? Contact else { return }
//        detailsController.viewModel = ContactViewModel(from: contact, pictureSize: 1300)
    }
}

extension ContactsTableViewController: ContentListViewDelegate {
    func contentDidChange() {
        refreshTable()
    }
    
    
}

