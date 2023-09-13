//
//  DetailsVC.swift
//  MovieApp
//
//  Created by hesham abd elhamead on 02/06/2023.
//

import UIKit

class DetailsVC: UIViewController {

    @IBOutlet weak var detrealseYear: UILabel!
    @IBOutlet weak var detRating: UILabel!
    @IBOutlet weak var deTitle: UILabel!
    @IBOutlet weak var detImage: UIImageView!
    var moive : movie?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: moive?.image ?? "")
        detImage .sd_setImage(with: url)
        
        if let rating = moive?.rating{
            detRating.text = "\(rating)"

        }
        
        deTitle.text = moive?.title
        
        if let year = moive?.releaseYear{
            detrealseYear.text = "\(year)"
        }
        

    }
    

   

}
