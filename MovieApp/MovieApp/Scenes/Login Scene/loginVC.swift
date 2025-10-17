//
//  loginVC.swift
//  MovieApp
//
//  Created by hesham abd elhamead on 04/06/2023.
//

import UIKit

class loginVC: UIViewController {
    let userDefaults = UserDefaults.standard
    @IBOutlet weak var userPassword: UITextField!
    @IBOutlet weak var userName: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
   
     @IBAction func buttonLogin(_ sender: Any) {
         let userName = userName.text
         let password = userPassword.text
         
         let shouldGoToNextScreen = verify(userName: userName, password: password)
        
         if shouldGoToNextScreen {
             userDefaults.set( true, forKey:UserDefaultsKeys.isLoggedIn )
         guard    let vc = self.storyboard?.instantiateViewController(withIdentifier:"movieList") as? MoviesListViewController else {return}
           self.navigationController?.pushViewController(vc, animated: true)
         }
         else{
             showError()
         }
     }
    
    
    func verify(userName : String?, password : String?)-> Bool{
        
        if (userName == "hesham" && password == "123456"){
            return true
        }
        else{
            return false
        }
    }
    
    private func showError() {
        let alert = UIAlertController(title: "Error", message: "user name or password is incorrect", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(ok)
        DispatchQueue.main.async { [weak self] in
            self?.present(alert, animated: true)
        }
        
    }
}
