//
//  SearchCell.swift
//  BooksSearch
//
//  Created by Firdavs Zokirov  on 11/08/21.
//

import UIKit
import SDWebImage

class SearchCell: UITableViewCell {

    @IBOutlet weak var booksImage: UIImageView!
    @IBOutlet weak var titleLBl: UILabel!
    @IBOutlet weak var authorLbl: UILabel!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    
    static func nib() -> UINib{
        return UINib(nibName: "SearchCell", bundle: nil)
    }
    
    static let identifier = "SearchCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        booksImage.layer.cornerRadius = booksImage.frame.height/7
    }
    func updateCell(image: String, title:String,author:String){
        titleLBl.text = title
        authorLbl.text = author
        booksImage.sd_setImage(with: URL(string: image), placeholderImage: UIImage(systemName: ""))
    }

    
}
