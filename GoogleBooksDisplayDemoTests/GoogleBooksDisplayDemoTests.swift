//
//  GoogleBooksDisplayDemoTests.swift
//  GoogleBooksDisplayDemoTests
//
//  Created by Admin on 5/26/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import XCTest
@testable import GoogleBooksDisplayDemo

class GoogleBooksDisplayDemoTests: XCTestCase, BookViewModelDelegate  {
    
    func handleData(books: [Book]) {
        self.exp?.fulfill()
    }
    
    
    var viewModel: BookViewModel!
    var exp: XCTestExpectation?

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewModel = BookViewModel()
        viewModel.delegate = self
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        exp = nil
    }
    
    func testInitial() {

        XCTAssert(viewModel.searchController.searchBar.text?.count == 0, "There should not be any search text yet")
        XCTAssertTrue(viewModel.arr_books.isEmpty, "There should be no results yet")
    }
    
    func testSearch(){
        viewModel.getBooks(search: "Lord of the Rings")
        exp = expectation(description: "Waiting for Google response")
        waitForExpectations(timeout: 5){ error in
            XCTAssertFalse(self.viewModel.arr_books.isEmpty,
                           "There should be some results")
            
        }
    }
    
}
