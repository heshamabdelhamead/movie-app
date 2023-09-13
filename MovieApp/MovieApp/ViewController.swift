//
//  ViewController.swift
//  MovieApp
//
//  Created by hesham abd elhamead on 31/05/2023.
//

import UIKit
import SDWebImage

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!

    var movieArray : [movie]?{
        didSet{
            DispatchQueue.main.async {
            self.collectionView.reloadData()
           }
        }
    }
    
    var i = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = nil
         // Do any additional setup after loading the view.
         movieArray = [movie]()
       
        let url = URL(string: "https://gist.githubusercontent.com/alanponce/d8a5e47b4328b5560fb610c5731de2bd/raw/b9f2a2b20d7d71f0e9c31adf40c7c83308809ac0/movies.json")
        let request = URLRequest(url: url! )
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { [self]  (data, respond, error) in
            do {
                var json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! Array< Dictionary<String,Any>>

                for rawMovie in json{
                    
                    var    objectMovie = movie()
                    objectMovie.title = rawMovie["title"] as? String
                    objectMovie.image = filmsphoto[i]
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
    
}



extension ViewController : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return  (movieArray?.count)!
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! MovieCell
        cell.movieTitle.text = movieArray![indexPath.row].title
        
        let url = URL(string: movieArray?[indexPath.row].image ?? "")

            cell.movieImage .sd_setImage(with: url)
        return cell

    }
     // to make collectionView with to cell  in all modes
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numcol:CGFloat = 2
        let collectionViewWidth = collectionView.bounds.width
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        let spaceBetweenCells = layout.minimumInteritemSpacing * (numcol-1)
        let exactWidth = floor ((collectionViewWidth - spaceBetweenCells)/numcol )
        return CGSize(width: exactWidth, height: exactWidth)

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailsVC") as! DetailsVC
        vc.moive = movieArray![indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    // solve the problem of landScapem mode
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    
}

