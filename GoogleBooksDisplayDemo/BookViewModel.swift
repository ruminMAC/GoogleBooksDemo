//
//  BookViewModel.swift
//  GoogleBooksDisplayDemo
//
//  Created by Admin on 5/26/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

protocol BookViewModelDelegate: class {
    
    func handleData(books:[Book])
}



class BookViewModel: NSObject {
    
    var arr_books:[Book] = []
    var delegate: BookViewModelDelegate?
    let searchController = UISearchController(searchResultsController: nil)
    
    override init()
    {
        super.init()
        
        searchController.searchBar.delegate = self
        searchController.searchBar.returnKeyType = .default
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Books"
        searchController.isActive = true
    }
    
    func getBooks(search: String){
        
        BookService.volume = search
        BookService.shared.getBooks { (books) in
            self.arr_books = books
            self.delegate?.handleData(books: self.arr_books)
        }
    }
}

extension BookViewModel: UISearchBarDelegate
{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let text = searchBar.text else { return }
        getBooks(search: text)
    }
    
}


