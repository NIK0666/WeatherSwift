//
//  StartRouter.swift
//  Weather
//
//  Created by NIKO on 22/01/2019.
//  Copyright © 2019 NIKO. All rights reserved.
//

import UIKit
import RxCocoa

final class StartRouter: RouterProtocol, SelectRegionDelegate {
    
    enum RouteType {
        case selectRegion
        case general(GeneralModel)
    }
    
    weak var baseVC: UIViewController?
    
    let selectedCity = BehaviorRelay<City?>(value: nil)
    
    func enqueueRoute(with context: Any?, animated: Bool, completion: ItemClosure<Bool>?) {
        
        guard let type = context as? RouteType else {
            assertionFailure("Route type mismatch")
            return
        }
        
        guard let viewController = baseVC else {
            assertionFailure("baseVC is not set")
            return
        }
        
        switch type {
        case .selectRegion:
            let router = SelectRegionRouter()
            //router.present(on: viewController)
            router.present(on: viewController, animated: true, context: SelectRegionRouter.RoutePresentType.showWith(self), completion: nil)
        case .general(let model):
            let router = GeneralRouter()
            router.present(on: viewController, animated: true, context: GeneralRouter.RouteType.view(model), completion: nil)
        }
        
    }
    
    func present(on baseViewController: UIViewController, animated: Bool, context: Any?, completion: ItemClosure<Bool>?) { }
    
    func dismiss(animated: Bool, context: Any?, completion: ItemClosure<Bool>?) { }
    
}
