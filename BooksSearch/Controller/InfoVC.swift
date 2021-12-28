//
//  InfoVC.swift
//  BooksSearch
//
//  Created by Firdavs Zokirov  on 11/08/21.
//

import UIKit
import SDWebImage

class InfoVC: UIViewController {
    
    //MARK: - INFOVC: Title, Author, Description, Thumbnail.
    
    
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var bookName: UILabel!
    @IBOutlet weak var bookDescription: UILabel!
    @IBOutlet weak var booksImage: UIImageView!
   
    var book: BooksDM!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navBarBackground()
        
        author.text = book.author
        bookName.text = book.title
        bookDescription.text = book.description
        booksImage.sd_setImage(with: URL(string: book.image), placeholderImage: UIImage(systemName: "trash"))
        
    }
    
    
    func navBarBackground(){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.layoutIfNeeded()
    }
    
    
    func fetchRequest(){
        
    }
    
}
