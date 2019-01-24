//
//  SelectRegionViewModel.swift
//  Weather
//
//  Created by NIKO on 23/01/2019.
//  Copyright © 2019 NIKO. All rights reserved.
//

import Foundation
import RealmSwift
import RxCocoa
import RxSwift

protocol SelectRegionViewModelProtocol: ViewModelProtocol {
    
    var searchText: BehaviorRelay<String> { get }
    var cities: BehaviorRelay<[City]> { get }
    
    var cancelTapped: PublishSubject<Void> { get }
    var cityIndexSelected: PublishSubject<Int> { get }
}

class SelectRegionViewModel: SelectRegionViewModelProtocol {
    var searchText = BehaviorRelay<String>(value: "")
    var cities = BehaviorRelay<[City]>(value: [])
    
    var cancelTapped = PublishSubject<Void>()
    var cityIndexSelected = PublishSubject<Int>()
    
    private let disposeBag = DisposeBag()
    
    var router: RouterProtocol
    
    init(with router: SelectRegionRouter) {
        self.router = router
        
        setupBundings()
    }
    
    func setupBundings() {
        searchText.asObservable().subscribe({[weak self] text in
            DispatchQueue.main.async {
                let realm = try! Realm()
                let results = realm.objects(City.self).sorted(byKeyPath: "name").filter("name BEGINSWITH '\(text.element!.capitalized)'")
                self?.cities.accept(Array(results))
            }
        }).disposed(by: disposeBag)
        
        cancelTapped.subscribe({[weak self] _ in
            self?.router.dismiss(animated: true, context: SelectRegionRouter.RouteDismissType.cancel, completion: nil)
        }).disposed(by: disposeBag)
        
        cityIndexSelected.subscribe({ [weak self] index in
            if let city = self?.cities.value[index.element!] {
                self?.router.dismiss(animated: true, context: SelectRegionRouter.RouteDismissType.back(city), completion: nil)
            }
        }).disposed(by: disposeBag)
    }
    
}
