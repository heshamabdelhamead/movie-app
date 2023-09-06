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
      //  detrealseYear.text = "\(movie?.releaseYear)"
        let url = URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRckfNYvbQdzr5NZpRd58mj19YozOocQMyQ6Buv6dAnJq5V58hZZyak73mOKB-Roz2Kwy4&usqp=CAU")
        detImage .sd_setImage(with: url)
        if let rating = moive?.rating{
            detRating.text = "\(rating)"

        }
        deTitle.text = moive?.title
        if let year = moive?.releaseYear{
            detrealseYear.text = "\(year)"
        }
        

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
