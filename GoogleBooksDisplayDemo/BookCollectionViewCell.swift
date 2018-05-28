//
//  BookCollectionViewCell.swift
//  GoogleBooksDisplayDemo
//
//  Created by Admin on 5/27/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class BookCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var lbl_title: UILabel!
    @IBOutlet weak var imgView_thumbnail: UIImageView!
    @IBOutlet weak var lbl_author: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lbl_title.numberOfLines = 0
    }
    
    override func prepareForReuse() {
        imgView_thumbnail.image = nil
        
    }
    
    func configureCell(with book: Book){
        
        lbl_title.text = book.volumeInfo.title
        lbl_author.text = book.volumeInfo.authors[0]
        
        guard let url = URL(string: book.volumeInfo.imageLinks.thumbnail) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if error == nil
            {
                guard let imageData = data else {return}
                
                DispatchQueue.main.async {
                    self.imgView_thumbnail.image = UIImage(data: imageData)
                }

            }
            
        }.resume()
        
    }

}
