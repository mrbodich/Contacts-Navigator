//
//  ViewModelTests.swift
//  Contacts Navigator Tests
//
//  Created by Bogdan Chornobryvets on 17.06.2021.
//

import XCTest
@testable import Contacts_Navigator

class ViewModelTests: XCTestCase {
    
    var viewModelFabric: ContentViewModelFabric!
    var expectation: XCTestExpectation?

    override func setUpWithError() throws {
        viewModelFabric = ContactsViewModelFabric()
    }

    override func tearDownWithError() throws {
        viewModelFabric = nil
    }

    func testContactDetailsViewModel() throws {
        
        let contentModel = ContactModel(id: "one", firstName: "John", lastName: "Brown", email: "john.brown@host.com")
        let viewModel = viewModelFabric.detailsViewModel(for: contentModel)
        
        XCTAssertEqual(viewModel.title, "John")
        XCTAssertEqual(viewModel.subtitle, "Brown")
        XCTAssertEqual(viewModel.details, "john.brown@host.com")
    }
    
    func testContactsCellViewModel() throws {
        
        let contentModel = ContactModel(id: "one", firstName: "John", lastName: "Brown", email: "john.brown@host.com")
        let viewModel = viewModelFabric.contentListCellViewModel(for: contentModel)
        
        XCTAssertEqual(viewModel.title, "John")
        XCTAssertEqual(viewModel.subtitle, "Brown")
        XCTAssertEqual(viewModel.details, "john.brown@host.com")
    }
    
    func testListCoordinator() {
        expectation = expectation(description: "List ViewModel contentDidChange")
        
        let listViewModel = ContactsListViewModel()
        listViewModel.contentListCoordinatorDelegate = self
        listViewModel.contentListViewDelegate = self
        
        let contactsFetcher = ContactsLocalFetcher(defaultContent: [ContactModel(id: "0", firstName: "John", lastName: "Brown", email: "john.brown@host.com"),
                                                                    ContactModel(id: "1", firstName: "Lisa", lastName: "Shwartz", email: "lisa.shwartz@host.com"),
                                                                    ContactModel(id: "2", firstName: "Denis", lastName: "Williams", email: "denis.williams@host.com")])
        
        let contactListModel = ContactsListModel(contentFetcher: contactsFetcher)
        listViewModel.model = contactListModel
        
        
        
        wait(for: [expectation!], timeout: 1)
    }

}

extension ViewModelTests: ContentListCoordinatorDelegate {
    func contentViewModel(for model: ContentModel) -> ContentViewModel {
        let imageFetcher = CacheImageFetcher()
        return ContactDetailsViewModel(model: model, imageFetcher: imageFetcher, imageSize: 80)
    }

    func listItemDidSelect(with model: ContentModel) {
        
    }
}

extension ViewModelTests: ContentListViewDelegate {
    func contentDidChange() {
        expectation?.fulfill()
    }
}
