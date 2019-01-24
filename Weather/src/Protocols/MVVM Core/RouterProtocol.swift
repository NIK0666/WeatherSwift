//
//  RouterProtocol.swift
//  Weather
//
//  Created by NIKO on 23/01/2019.
//  Copyright © 2019 NIKO. All rights reserved.
//

import UIKit

protocol RouterProtocol {
    
    weak var baseVC: UIViewController? { get set }

    func present(on baseViewController: UIViewController, animated: Bool, context: Any?, completion: ItemClosure<Bool>?)
    func enqueueRoute(with context: Any?, animated: Bool, completion: ItemClosure<Bool>?)
    func dismiss(animated: Bool, context: Any?, completion: ItemClosure<Bool>?)
}

extension RouterProtocol {
    func present(on baseViewController: UIViewController) {
        self.present(on: baseViewController, animated: true, context: nil, completion: nil)
    }
    
    func enqueueRoute(with context: Any?) {
        self.enqueueRoute(with: context, animated: true, completion: nil)
    }
    
    func enqueueRoute(with context: Any?, completion: ItemClosure<Bool>?) {
        self.enqueueRoute(with: context, animated: true, completion: completion)
    }
}
