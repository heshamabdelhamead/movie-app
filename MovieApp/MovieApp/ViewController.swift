//
//  ViewController.swift
//  MovieApp
//
//  Created by hesham abd elhamead on 31/05/2023.
//

import UIKit
import SDWebImage

class ViewController: UIViewController {
    var i = 0

    @IBOutlet weak var collectionView: UICollectionView!

    var movieArray : [movie]?{
        didSet{
            DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
        }
    }
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = nil
         // Do any additional setup after loading the view.
         movieArray = [movie]()
       
        let url = URL(string: "https://gist.githubusercontent.com/alanponce/d8a5e47b4328b5560fb610c5731de2bd/raw/b9f2a2b20d7d71f0e9c31adf40c7c83308809ac0/movies.json")
        let request = URLRequest(url: url! )
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { (data, respond, error) in
         //   print(data)
         //   print("data recvied sucsffuly")
            do {
                var json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! Array< Dictionary<String,Any>>
             //   print (json[0])

                for rawMovie in json{
                    var    objectMovie = movie()

                    objectMovie.title = rawMovie["title"] as? String
                  //  objectMovie.image = rawMovie["image"] as? String
                    objectMovie.rating = rawMovie["rating"] as? Double
                    objectMovie.releaseYear = rawMovie["releaseYear"] as? Int

                    self.movieArray!.append(objectMovie)
                    
                    
                }
//                for i in self.movieArray!{
//                    print(i.title)
//                }
                
               
            }
            
            catch{
                print("error")
            }

            
        }
        task.resume()
    }
    var filmsphoto = ["https://m.media-amazon.com/images/M/MV5BNTA5MDM1NjM5OF5BMl5BanBnXkFtZTgwNzAyMTMyMjE@._V1_.jpg","https://www.nme.com/wp-content/uploads/2021/02/District-9-1.jpg","https://m.media-amazon.com/images/M/MV5BNjUwMzMyODEyOF5BMl5BanBnXkFtZTgwNjIwODYwMjE@._V1_.jpg","https://images.bauerhosting.com/legacy/empire-tmdb/films/127585/images/ai9UKd8KownQKGIh1m5p3DuEeMm.jpg?format=jpg&quality=80&width=960&height=540&ratio=16-9&resize=aspectfill","https://wwv.dramacafe-tv.com/uploads/thumbs/54734a976-1.jpg","https://gaijinpot.scdn3.secure.raxcdn.com/app/uploads/sites/4/2015/04/last-samurai.jpg","https://i.kinja-img.com/gawker-media/image/upload/c_fill,f_auto,fl_progressive,g_center,h_675,pg_1,q_80,w_1200/a82732ef9974da9c2e5a6e4771ddf96a.jpg","https://lumiere-a.akamaihd.net/v1/images/pp_tangled_herobanner_mobile_20509_a32967be.jpeg?region=0,0,640,480","https://wwv.dramacafe-tv.com/uploads/thumbs/419d68532-1.jpg","https://www.gbhbl.com/wp-content/uploads/2020/06/rsz_1unnamed.jpg","https://rogermooresmovienation.files.wordpress.com/2013/07/despicable-me-2-image09.jpg","https://static1.srcdn.com/wordpress/wp-content/uploads/2020/05/Featured-Kill-Bill.jpg" ,"https://static1.srcdn.com/wordpress/wp-content/uploads/2022/12/a-bugs-life-insects.jpg","https://images.theconversation.com/files/311911/original/file-20200126-81357-1ysqznj.jpg?ixlib=rb-1.1.0&rect=0%2C50%2C1166%2C626&q=20&auto=format&w=320&fit=clip&dpr=2&usm=12&cs=strip","https://images.thedirect.com/media/article_full/dragon1.jpg"]


}



extension ViewController : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return  (movieArray?.count)!
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! MovieCell
        cell.movieTitle.text = movieArray![indexPath.row].title
        
        let url = URL(string: filmsphoto[i])

            cell.movieImage .sd_setImage(with: url)
            
            i += 1
        
        
        
        return cell

    }
//    override func viewWillAppear(_ animated: Bool) {
//
//        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//            let numcol:CGFloat = 2
//            let collectionViewWidth = collectionView.bounds.width
//            let layout = collectionViewLayout as! UICollectionViewFlowLayout
//            let spaceBetweenCells = layout.minimumInteritemSpacing * (numcol-1)
//            let exactWidth = floor ((collectionViewWidth - spaceBetweenCells)/numcol)
//            return CGSize(width: exactWidth, height: 100 )
//        }
//    }
    
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
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    
}

