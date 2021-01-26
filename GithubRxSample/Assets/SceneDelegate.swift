//
//  SceneDelegate.swift
//  GithubRxSample
//
//  Created by Alexander Krylov on 26/05/2020.
//  Copyright © 2020 Alexander Krylov. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    let navigator = Navigator()
    
    //MARK: UISceneDelegate

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let _ = (scene as? UIWindowScene) else { return }
        
        guard let nav = window?.rootViewController as? UINavigationController
            else { return }
        
        navigator.show(.main, sender: nav)
    }
}

