//
//  Book.swift
//  GoogleBooksDisplayDemo
//
//  Created by Admin on 5/26/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation
struct BookResponse: Decodable {
    let items: [Book]
}

struct Book: Decodable {
    let volumeInfo: VolumeInfo
}

struct VolumeInfo: Decodable {
    let title: String
    let authors: [String]
    let imageLinks: ImageLink
}

struct ImageLink: Decodable {
    
    let thumbnail: String
    
}




