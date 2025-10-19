//
//  MoviesListViewController.swift
//  MovieApp
//
//  Created by hesham abd elhamead on 31/05/2023.
//

import UIKit
import SDWebImage

class MoviesListViewController: UIViewController {
    
    private  var i = 0
    var movieArray : [MovieModel]?{
        didSet{
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupView()
    }
    private  func setupView(){
        movieArray = [MovieModel]()
        navigationItem.leftBarButtonItem = nil
        setupMoviesListCollectionView()
        fetchData()
    }
    private func  setupMoviesListCollectionView(){
        let cellNib = UINib(nibName: MovieListCollectionViewCell.identifier, bundle: nil)
        collectionView.register(cellNib, forCellWithReuseIdentifier: MovieListCollectionViewCell.identifier)
    }
    
    private func fetchData(){
        let url = URL(string: "https://gist.githubusercontent.com/alanponce/d8a5e47b4328b5560fb610c5731de2bd/raw/b9f2a2b20d7d71f0e9c31adf40c7c83308809ac0/movies.json")
        let request = URLRequest(url: url! )
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { [self]  (data, respond, error) in
            do {
                guard let data else {  showError();  return}
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! Array< Dictionary<String,Any>>
                
                for rawMovie in json{
                    
                    let    objectMovie = MovieModel()
                    objectMovie.title = rawMovie["title"] as? String
                    objectMovie.image =   filmsPhoto[i] // there is no images in the end point , so i replaced them with local ones
                    objectMovie.rating = rawMovie["rating"] as? Double
                    objectMovie.releaseYear = rawMovie["releaseYear"] as? Int
                    self.movieArray!.append(objectMovie)
                    i += 1
                }
                
            }
            
            catch{
                print("error")
            }
        }
        task.resume()
    }
    
    private func showError(){
        let alert = UIAlertController(title: "Error", message: "Something went wrong", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(ok)
        DispatchQueue.main.async { [weak self] in
            self?.present(alert, animated: true)
        }
    }
    
}

extension MoviesListViewController : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  (movieArray?.count) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieListCollectionViewCell.identifier, for: indexPath) as? MovieListCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.setupCell(with: movieArray?[indexPath.row])
        return cell
    }
    // to make collectionView with to cell  in all modes
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let collectionViewWidth = collectionView.bounds.width
        let availableWidth = collectionViewWidth / 2
        return CGSize(width: availableWidth, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Detail", bundle: nil)
        guard  let vc = storyBoard.instantiateViewController(withIdentifier: DetailViewController.identifier) as? DetailViewController else {return}
        vc.movie = movieArray?[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

