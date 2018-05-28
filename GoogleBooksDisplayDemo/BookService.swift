//
//  BookService.swift
//  GoogleBooksDisplayDemo
//
//  Created by Admin on 5/26/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation

class BookService {
    
    static var volume: String!
    
    fileprivate struct API {
        
        static let base = "https://www.googleapis.com/books/v1/volumes?q="
        
        static let key = "AIzaSyBipPzh_dj2HCJVlPMo4OTKLGqktKiQx-4"
        
    }
    
    static let shared = BookService()
    private init() { }
    
    typealias BooksHandler = ([Book]) -> Void
    
    func getBooks(completion:@escaping BooksHandler) {
        
        let searchedVolume = BookService.volume.components(separatedBy: " ")
        if searchedVolume.count > 0
        {
            BookService.volume = BookService.volume.replacingOccurrences(of: " ", with: "+")
        }
        
        let url = API.base + BookService.volume + "&key=" + API.key
        
        
        guard let urlBook = URL(string: url) else {return}
        
        URLSession.shared.dataTask(with: urlBook) { (data, response, error) in
            
            if error == nil
            {
                do {
                    guard let jsonData = data else {return}
                    let response = try JSONDecoder().decode(BookResponse.self, from: jsonData)
                    completion(response.items)
                    
                }catch{
                    //print("failed")
                }
            }
        }.resume()
    }
}
