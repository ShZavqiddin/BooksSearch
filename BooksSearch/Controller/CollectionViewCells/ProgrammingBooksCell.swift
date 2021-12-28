//
//  ProgrammingBooksCell.swift
//  BooksSearch
//
//  Created by Firdavs Zokirov  on 11/08/21.
//

import UIKit
import SDWebImage
class ProgrammingBooksCell: UICollectionViewCell {

    
     static func nib() -> UINib{
        return UINib(nibName: "ProgrammingBooksCell", bundle: nil)
    }
    static let identifier = "ProgrammingBooksCell"
    
    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var booksImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        booksImage.layer.cornerRadius = booksImage.frame.height/10
        
    }
    
    func updateCell(image:String){
            booksImage.sd_setImage(with: URL(string: image), placeholderImage: UIImage(systemName: ""))
    }

}
