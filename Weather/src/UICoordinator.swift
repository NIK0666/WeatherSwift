//
//  UICoordinator.swift
//  Weather
//
//  Created by NIKO on 22/01/2019.
//  Copyright © 2019 NIKO. All rights reserved.
//

import UIKit
class UICoordinator {
    
    func presentStartScreen(_ window: inout UIWindow?) {
        
        let frame = UIScreen.main.bounds
        window = UIWindow(frame: frame)
        window?.makeKeyAndVisible()
        
        let router = StartRouter()
        let viewModel = StartViewModel.init(with: router)
        let rootViewConttroller = StartViewController()
        
        rootViewConttroller.viewModel = viewModel
        router.baseVC = rootViewConttroller
        
        window?.rootViewController = UINavigationController(rootViewController: rootViewConttroller)
    }
}

