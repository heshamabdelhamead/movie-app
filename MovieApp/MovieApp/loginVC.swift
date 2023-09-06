//
//  loginVC.swift
//  MovieApp
//
//  Created by hesham abd elhamead on 04/06/2023.
//

import UIKit

class loginVC: UIViewController {

    @IBOutlet weak var userPassword: UITextField!
    @IBOutlet weak var userName: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    let userdefaults = UserDefaults.standard

    
     @IBAction func buttonLogin(_ sender: Any) {
         let userName = userName.text
         let password = userPassword.text
         
         let shouldGoToNextScreen = verify(userName: userName, password: password)
        
         if shouldGoToNextScreen {
             userdefaults.set( true, forKey: "loginScreen")
            
             let vc = self.storyboard?.instantiateViewController(withIdentifier:"movieList") as! ViewController
         // let appDelgate = UIApplication.shared.delegate as! AppDelegate
   //     appDelgate.appWindow?.rootViewController = vc
           self.navigationController?.pushViewController(vc, animated: true)
         }
         else{
             print("user name or password is incrocet")
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
    
    
    /*
     // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
