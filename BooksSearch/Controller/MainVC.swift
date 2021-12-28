//
//  MainVC.swift
//  BooksSearch
//
//  Created by Firdavs Zokirov  on 11/08/21.
//

import UIKit
import Lottie
import Alamofire
import SwiftyJSON


class MainVC: UIViewController {
    
    @IBOutlet weak var bookSearch: UIButton!{
        didSet{
            bookSearch.layer.cornerRadius = bookSearch.frame.height/5
        }
    }
    
    @IBOutlet weak var animationView: AnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lottiePlay()
        navBarBackground()
    }
    
    func navBarBackground(){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.layoutIfNeeded()
    }
    
    func lottiePlay(){
        
        // 1. Set animation content mode
        
        animationView.contentMode = .scaleAspectFit
        
        // 2. Set animation loop mode
        
        animationView.loopMode = .loop
        
        // 3. Adjust animation speed
        
        animationView.animationSpeed = 0.5
        
        // 4. Play animation
        animationView.play()
    }
    
    @IBAction func bookSearchBtnTapped(_ sender: Any) {
        animationView.stop()
        //
        //        let url = "https://www.googleapis.com/books/v1/volumes?q="
        //        let base_url = url + "swift"
        //        AF.request(base_url).responseJSON { (response) in
        //            if let data = response.data{
        //                print(JSON(data))
        //            }
        //        }
        
        let vc = SearchResults(nibName:"SearchResults", bundle: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

