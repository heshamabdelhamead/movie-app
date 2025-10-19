//
//  MovieListCollectionViewCell.swift
//  MovieApp
//
//  Created by hesham abd elhamead on 19/10/2025.
//

import UIKit

class MovieListCollectionViewCell: UICollectionViewCell {
    static let identifier = "MovieListCollectionViewCell"
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell(with movie: MovieModel?) {
        guard  let movie else { return }
        movieTitle.text = movie.title
        movieImage.sd_setImage(with: URL(string: movie.image ?? "" ))
    }
}
