//
//  SearchResults.swift
//  BooksSearch
//
//  Created by Firdavs Zokirov  on 11/08/21.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage
class SearchResults: UIViewController {
    
    @IBOutlet weak var collection_view: UICollectionView!{
        didSet{
            collection_view.delegate = self
            collection_view.dataSource = self
            collection_view.register(ProgrammingBooksCell.nib(), forCellWithReuseIdentifier: ProgrammingBooksCell.identifier)
            collection_view.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        }
    }
    
    @IBOutlet weak var table_view: UITableView!{
        didSet{
            table_view.delegate = self
            table_view.dataSource = self
            table_view.register(SearchCell.nib(), forCellReuseIdentifier: SearchCell.identifier)
            table_view.layer.cornerRadius = table_view.frame.height/20
            table_view.rowHeight = 150
            table_view.backgroundColor = .clear
            table_view.separatorStyle = .none
        }
    }
    
    @IBOutlet weak var search_bar: UISearchBar!{
        didSet{
            search_bar.delegate = self
        }
    }

 
    var booksArr: [BooksDM] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        navBarBackground()
        
    }
    
    func navBarBackground(){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.layoutIfNeeded()
    }
}

extension SearchResults: UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if !booksArr.isEmpty{
            return booksArr.count
        } else {
            return 4
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection_view.dequeueReusableCell(withReuseIdentifier: ProgrammingBooksCell.identifier, for: indexPath) as! ProgrammingBooksCell
        if !booksArr.isEmpty{
            cell.loader.stopAnimating()
            cell.loader.isHidden = true
            collection_view.isHidden = false
            cell.updateCell(image: booksArr[indexPath.row].image)
            print(booksArr[indexPath.row].image)
        }else{
            cell.loader.startAnimating()
            collection_view.isHidden = true
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.collection_view.bounds.width-20)/4, height:self.collection_view.bounds.height-20)
    }
    
    
}


extension SearchResults: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !booksArr.isEmpty{
            return booksArr.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table_view.dequeueReusableCell(withIdentifier: SearchCell.identifier, for: indexPath) as! SearchCell
        if !booksArr.isEmpty {
            cell.loader.stopAnimating()
            cell.loader.isHidden = true
            cell.updateCell(image: booksArr[indexPath.row].image ,title: booksArr[indexPath.row].title, author: booksArr[indexPath.row].author)
            cell.selectionStyle = .none
            table_view.isHidden = false
        }else{
            cell.loader.startAnimating()
            table_view.isHidden = true
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = InfoVC(nibName: "InfoVC", bundle: nil)
        vc.book = booksArr[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension SearchResults:UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let baseUrl = "https://www.googleapis.com/books/v1/volumes?q="
        let url = baseUrl + searchBar.text!.replacingOccurrences(of: " ", with: "")
        print(url)
        AF.request(URL(string:url) ?? "", method: .get).responseJSON { (response) in
            if let data = response.data{
                let jsonData = JSON(data)
                print(jsonData)
                let dat = jsonData["items"]
                let erorr = jsonData["error"]
                if erorr.arrayValue != nil {

                    
                    
                }
                self.booksArr.removeAll()
                for d in 0..<dat.count{
                    var f = ""
                    for i in dat[d]["volumeInfo"]["authors"].arrayValue {
                        f.append(i.stringValue)
                    }
                    let books = BooksDM(image:  dat[d]["volumeInfo"]["imageLinks"]["thumbnail"].stringValue, title: dat[d]["volumeInfo"]["title"].stringValue, author: f, description: dat[d]["volumeInfo"]["description"].stringValue)
                    self.booksArr.append(books)
                    self.table_view.reloadData()
                    self.collection_view.reloadData()
                }
            }
        }
        searchBar.resignFirstResponder()
    }
    
}
