//
//  SceneDelegate.swift
//  MovieApp
//
//  Created by hesham abd elhamead on 31/05/2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
//    func setRootViewController() {
//        let isLoginIn = UserDefaults.standard.bool(forKey: "loginScreen")
//        if isLoginIn {
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let vc = storyboard.instantiateViewController(withIdentifier: "movieList") as! ViewController
//            window?.rootViewController = vc
//        }
//        else {
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                let defaultVC = storyboard.instantiateViewController(withIdentifier: "login") as! loginVC
//                window?.rootViewController = defaultVC
//            }
//    }
    func setRootViewController() {
        let isLoginIn = UserDefaults.standard.bool(forKey: "loginScreen")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        if isLoginIn {
            let vc = storyboard.instantiateViewController(withIdentifier: "movieList") as! ViewController
          //  window?.rootViewController = vc
            let navController = UINavigationController(rootViewController: vc)
            window?.rootViewController = navController
        } else {
            let loginVC = storyboard.instantiateViewController(withIdentifier: "login") as! loginVC
            let navController = UINavigationController(rootViewController: loginVC)
            window?.rootViewController = navController
        }
    }



    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
            self.window = window

            // Call the method to set the root view controller
            setRootViewController()

            window.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

