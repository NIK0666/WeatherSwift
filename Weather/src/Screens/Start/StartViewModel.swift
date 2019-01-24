//
//  StartViewModel.swift
//  Weather
//
//  Created by NIKO on 23/01/2019.
//  Copyright © 2019 NIKO. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol StartViewModelProtocol: ViewModelProtocol {

    var isStartActive: BehaviorRelay<Bool> { get }
    var locationTitle: BehaviorRelay<String> { get }
    var currentLocation: BehaviorRelay<Coord?> { get }
    
    var enterLocationTapped: PublishSubject<Void> { get }
    var currentLocationTapped: PublishSubject<Void> { get }
    var startTapped: PublishSubject<Void> { get }
}


class StartViewModel: StartViewModelProtocol {
    
    let isStartActive = BehaviorRelay<Bool>(value: false)
    let locationTitle = BehaviorRelay<String>(value: "ENTER LOCATION")
    let currentLocation = BehaviorRelay<Coord?>(value: nil)
    
    let startTapped = PublishSubject<Void>()
    let currentLocationTapped = PublishSubject<Void>()
    let enterLocationTapped = PublishSubject<Void>()
    
    var router: RouterProtocol
    
    private var city: City?
    private var weather: WeatherResponce?
    private var forecast: ForecastResponse?
    private var timeZone: TimeZoneResponse?
    
    private let disposeBag = DisposeBag()
    private let weatherService = WeatherService()
    private let timeZoneService = TimeZoneService()
    
    init(with router: StartRouter) {
        self.router = router
        
        setupBindings()
    }
    
    func setupBindings() {

        startTapped.asObservable().subscribe({ _ in
            let model = GeneralModel(city: self.city, currentLocation: self.currentLocation.value, weather: self.weather!, forecast: self.forecast!, timeZone: self.timeZone!)
            self.router.enqueueRoute(with: StartRouter.RouteType.general(model))
        }).disposed(by: disposeBag)
        
        enterLocationTapped.asObservable().subscribe({ _ in
            self.router.enqueueRoute(with: StartRouter.RouteType.selectRegion)
        }).disposed(by: disposeBag)
        
        currentLocationTapped.asObservable().subscribe({ _ in
            self.isStartActive.accept(false)
        }).disposed(by: disposeBag)
        currentLocation.debounce(0.3, scheduler: MainScheduler.instance)
        .asObservable().subscribe({ coord in
            guard coord.element! != nil else { return }
            self.locationTitle.accept("Current location")
            self.city = nil //Обнулим город
            self.requestInformation() //Дергаем сервисы
        }).disposed(by: disposeBag)
        
        (router as! SelectRegionDelegate).selectedCity.asObservable().subscribe({ city in
            guard let city = city.element! else { return }
            self.isStartActive.accept(false)
            self.city = city
            self.currentLocation.accept(nil) //Обнулим координату
            self.locationTitle.accept(city.fullLocation())
            
            self.requestInformation() //TODO Дергаем сервисы
        }).disposed(by: disposeBag)
    }
    
    private func requestInformation() {
        
        let coord: Coord!
        var responceCounter = 0
        if self.currentLocation.value != nil {
            coord = self.currentLocation.value!
        } else if self.city != nil {
            coord = Coord(lon: city!.lon, lat: city!.lat)
        } else { return }
        
        weatherService.request(by: coord, sucessed: { (weather, forecast) in
            self.weather = weather
            self.forecast = forecast
            responceCounter += 1
            self.isStartActive.accept(responceCounter > 1)
        }) { error in
            print(error.localizedDescription)
        }
        
        timeZoneService.request(by: coord, complition: { timeZone in
            self.timeZone = timeZone
            responceCounter += 1
            self.isStartActive.accept(responceCounter > 1)
        }) { error in
            print(error.localizedDescription)
        }
    }
    
}
