//
//  DetailVC.swift
//  MovieApp
//
//  Created by hesham abd elhamead on 02/06/2023.
//

import UIKit

class DetailVC: UIViewController {
    static let identifier: String = "DetailVC"
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var detRating: UILabel!
    @IBOutlet weak var deTitle: UILabel!
    @IBOutlet weak var detImage: UIImageView!
    var movie : MovieModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView(){
        let url = URL(string: movie?.image ?? "")
        detImage.sd_setImage(with: url)
        
        if let rating = movie?.rating{
            detRating.text = "\(rating)"
        }
        deTitle.text = movie?.title
        if let year = movie?.releaseYear{
            self.year.text = "\(year)"
        }
    }
}
