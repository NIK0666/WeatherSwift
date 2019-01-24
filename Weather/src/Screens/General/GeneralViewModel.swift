//
//  GeneralViewModel.swift
//  Weather
//
//  Created by NIKO on 24/01/2019.
//  Copyright © 2019 NIKO. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

protocol GeneralViewModelProtocol: ViewModelProtocol {
    var locationTitle: BehaviorRelay<String> { get }
    var currentTimeString: BehaviorRelay<String> { get }
    var weatherIconName: BehaviorRelay<String?> { get }
    var temperatureString: BehaviorRelay<String> { get }
    var descriptionString: BehaviorRelay<String> { get }
    var showLoadingIndicator: BehaviorRelay<Bool> { get }
    var periods: BehaviorRelay<[PeriodModel]> { get }
    
    var model: BehaviorSubject<GeneralModel?> { get }
    var searchTapped: PublishSubject<Void> { get }
}

class GeneralViewModel: GeneralViewModelProtocol {
    
    
    
    let locationTitle = BehaviorRelay<String>(value: "")
    let currentTimeString = BehaviorRelay<String>(value: "")
    let weatherIconName = BehaviorRelay<String?>(value: nil)
    let temperatureString = BehaviorRelay<String>(value: "")
    let descriptionString = BehaviorRelay<String>(value: "")
    let showLoadingIndicator = BehaviorRelay<Bool>(value: false)
    let periods = BehaviorRelay<[PeriodModel]>(value: [])
    
    
    let model = BehaviorSubject<GeneralModel?>(value: nil)
    var searchTapped = PublishSubject<Void>()
    
    
    var router: RouterProtocol
    
    private let disposeBag = DisposeBag()
    private let weatherService = WeatherService()
    private let timeZoneService = TimeZoneService()
    
    private let currentDateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.timeZone = TimeZone(secondsFromGMT: 0)
        df.timeStyle = .short
        df.dateStyle = .medium
        return df
    }()
    
    init(router: GeneralRouter, model: GeneralModel) {
        self.router = router
        self.model.onNext(model)
        
        setupBindings()
        
    }
    
    func setupBindings() {
        model.asObserver().subscribe({ model in
            
            guard let weatherModel = model.element! else {
                self.locationTitle.accept("")
                self.currentTimeString.accept("")
                self.weatherIconName.accept("")
                self.temperatureString.accept("")
                self.descriptionString.accept("")
                self.periods.accept([])
                self.showLoadingIndicator.accept(true)
                return
            }
            
            guard let currentWeather = weatherModel.weather.weather.first else {
                assertionFailure("Bad weather model!")
                return
            }
            
            self.showLoadingIndicator.accept(false)
            
            //Selected location
            var location: String!
            if let city = weatherModel.city {
                location = city.fullLocation()
            } else {
                location = weatherModel.forecast.fullLocation()
            }
            self.locationTitle.accept(location)
            
            //Current weather
            self.weatherIconName.accept(weatherModel.weather.iconName())
            self.descriptionString.accept(currentWeather.description.capitalizingFirstLetter())
            self.temperatureString.accept(self.tempToString(weatherModel.weather.main.temp))
            
            //Current time
            let date = Date(timeIntervalSince1970: TimeInterval(weatherModel.timeZone.timestamp))
            self.currentTimeString.accept(self.currentDateFormatter.string(from: date))
            
            
            //Periods
            self.periods.accept(weatherModel.forecast.list.map{ (elem) -> PeriodModel in
                let offset = Int((weatherModel.timeZone.timestamp - weatherModel.weather.dt) / 3600) * 3600
                return PeriodModel(temperature: self.tempToString(elem.main.temp), iconName: elem.iconName(), timestamp: elem.dt + offset)
            })
            
            
            
            
        }).disposed(by: disposeBag)
        
        searchTapped.asObservable().subscribe({[weak self] _ in
            self?.router.enqueueRoute(with: GeneralRouter.RouteEnqueueType.selectRegion)
        }).disposed(by: disposeBag)
        
        
        (router as! SelectRegionDelegate).selectedCity.asObservable().subscribe({ city in
            guard let city = city.element! else { return }
            self.model.onNext(nil)
            
            var responceCounter = 0
            
            var weatherResponce: WeatherResponce!
            var forecastResponse: ForecastResponse!
            var timeZoneResponse: TimeZoneResponse!
            
            let coord = Coord(lon: city.lon, lat: city.lat)
            self.weatherService.request(by: coord, sucessed: { (weather, forecast) in
                weatherResponce = weather
                forecastResponse = forecast
                responceCounter += 1
                if responceCounter > 1 {
                    self.model.onNext(GeneralModel(city: city, currentLocation: coord, weather: weatherResponce, forecast: forecastResponse, timeZone: timeZoneResponse))
                }
            }) { error in
                print(error.localizedDescription)
            }
            
            self.timeZoneService.request(by: coord, complition: { timeZone in
                timeZoneResponse = timeZone
                responceCounter += 1
                if responceCounter > 1 {
                    self.model.onNext(GeneralModel(city: city, currentLocation: coord, weather: weatherResponce, forecast: forecastResponse, timeZone: timeZoneResponse))
                }
            }) { error in
                print(error.localizedDescription)
            }
        }).disposed(by: disposeBag)
    }
    
    func tempToString(_ temp: Double) -> String {
        return "\(Int(temp.rounded() - 273))°С"
    }
}
