//
//  ViewController.swift
//  GoogleBooksDisplayDemo
//
//  Created by Admin on 5/26/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class BookViewController: UIViewController {


    @IBOutlet weak var collectionView_books: UICollectionView!
    
    let bookViewModel = BookViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        navigationItem.searchController = bookViewModel.searchController
        definesPresentationContext = true
        
        bookViewModel.delegate = self
        bookViewModel.getBooks(search: "science")
        
        collectionView_books.register(UINib(nibName: "BookCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "bookCell")
        
 
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        bookViewModel.searchController.searchBar.becomeFirstResponder()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension BookViewController: UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return bookViewModel.arr_books.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bookCell", for: indexPath) as! BookCollectionViewCell
        
        let book = bookViewModel.arr_books[indexPath.row]
        
        cell.configureCell(with: book)
        
        return cell
        
    }
}

extension BookViewController: UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        collectionView.contentInset = UIEdgeInsetsMake(0, 15, 15, 15)
        let width  = self.view.frame.size.width
    
        return CGSize(width: width * 0.4, height: 229.0)
        
    }
    
}
extension BookViewController: BookViewModelDelegate
{
    func handleData(books: [Book]){
        DispatchQueue.main.async {
            self.collectionView_books.reloadData()
        }
    }
}





