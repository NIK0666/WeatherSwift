//
//  GeneralRouter.swift
//  Weather
//
//  Created by NIKO on 22/01/2019.
//  Copyright © 2019 NIKO. All rights reserved.
//

import UIKit
import RxCocoa

final class GeneralRouter: RouterProtocol, SelectRegionDelegate {
    
    
    
    enum RouteType {
        case view(GeneralModel)
    }
    enum RouteEnqueueType {
        case selectRegion
    }
    
    let selectedCity = BehaviorRelay<City?>(value: nil)
    
    var baseVC: UIViewController?
    
    func enqueueRoute(with context: Any?, animated: Bool, completion: ItemClosure<Bool>?) {
        guard let type = context as? RouteEnqueueType else {
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
            router.present(on: viewController, animated: true, context: SelectRegionRouter.RoutePresentType.showWith(self), completion: nil)
        }
    }
    
    func present(on baseViewController: UIViewController, animated: Bool, context: Any?, completion: ItemClosure<Bool>?) {
        guard let type = context as? RouteType else {
            assertionFailure("Route type mismatch")
            return
        }
        
        let vc = GeneralViewController()
        
        switch type {
        case .view(let model):
            let viewModel = GeneralViewModel.init(router: self, model: model)
            vc.viewModel = viewModel
            baseViewController.navigationController?.setViewControllers([vc], animated: true)
        }
        baseVC = vc
    }
    
    func dismiss(animated: Bool, context: Any?, completion: ItemClosure<Bool>?) {
        
    }
}
