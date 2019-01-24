//
//  SearchRegionRouter.swift
//  Weather
//
//  Created by NIKO on 22/01/2019.
//  Copyright © 2019 NIKO. All rights reserved.
//

import UIKit
import RxCocoa

protocol SelectRegionDelegate {
    var selectedCity: BehaviorRelay<City?> { get }
}

final class SelectRegionRouter: RouterProtocol {
    
    enum RouteDismissType {
        case back(City)
        case cancel
    }
    
    enum RoutePresentType {
        case showWith(SelectRegionDelegate)
    }
    
    weak var baseVC: UIViewController?
    var delegate: SelectRegionDelegate?
    
    func enqueueRoute(with context: Any?, animated: Bool, completion: ItemClosure<Bool>?) {
        
    }
    
    func present(on baseViewController: UIViewController, animated: Bool, context: Any?, completion: ItemClosure<Bool>?) {
        
        guard let type = context as? RoutePresentType else {
            assertionFailure("Route type mismatch")
            return
        }
        
        switch type {
        case .showWith(let baseRouter):
            self.delegate = baseRouter
        }
        
        
        
        let viewController = SelectRegionViewController()
        
        let viewModel = SelectRegionViewModel.init(with: self)
        viewController.viewModel = viewModel
        
        baseViewController.navigationController?.pushViewController(viewController, animated: true)
        baseViewController.navigationController?.interactivePopGestureRecognizer?.delegate = viewController as? UIGestureRecognizerDelegate

        baseVC = viewController
        
    }
    
    func dismiss(animated: Bool, context: Any?, completion: ItemClosure<Bool>?) {
        guard let type = context as? RouteDismissType else {
            return
        }
        
        switch type {
        case .cancel: break
        case .back(let city):
            delegate!.selectedCity.accept(city)
        }
        
        baseVC?.navigationController?.popViewController(animated: true)
        delegate = nil
        
    }
    
        
}
