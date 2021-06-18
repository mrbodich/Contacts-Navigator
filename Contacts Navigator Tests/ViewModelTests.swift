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
        expectation = nil
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
        
        let contactsFetcher = ContactsFetcherMock()
        
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

fileprivate final class ContactsFetcherMock: ContentFetcher {
    
    private var defaultContent: [ContentModel]
    
    init() {
        var contentList: [ContactModel] = []
        contentList.append(ContactModel(id: "0", firstName: "Serg", lastName: "Brown", email: "serg.brown@gmail.com"))
        contentList.append(ContactModel(id: "1", firstName: "Mary", lastName: "Laura", email: "mary@gmail.com"))
        contentList.append(ContactModel(id: "2", firstName: "Gary", lastName: "Solarus", email: "solarus@gmail.com"))
        contentList.append(ContactModel(id: "3", firstName: "Richard", lastName: "Lipstigh", email: "rlipstigh@gmail.com"))
        contentList.append(ContactModel(id: "4", firstName: "Paul", lastName: "Born", email: "paul12345@gmail.com"))
        contentList.append(ContactModel(id: "5", firstName: "Prometheus", lastName: "Calin", email: "prom.calin@gmail.com"))
        
        defaultContent = contentList
    }
    
    func fetchContentList(_ completion: @escaping (_ content: [ContentModel]) -> ()) {
        completion(defaultContent)
    }
}
