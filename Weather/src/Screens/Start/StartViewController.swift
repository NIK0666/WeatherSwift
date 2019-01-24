//
//  StartViewController.swift
//  Weather
//
//  Created by NIKO on 22/01/2019.
//  Copyright © 2019 NIKO. All rights reserved.
//

import UIKit
import CoreLocation
import RxSwift
import RxCocoa

class StartViewController: UIViewController, GradientBackgroundProtocol, MVVMViewController {

    private let disposeBag = DisposeBag()
    var viewModel: StartViewModelProtocol!
    
    @IBOutlet private weak var iconView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var enterLocationButton: LocationButton!
    @IBOutlet private weak var startButton: NUButton!
    
    
    
    private let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
    }
    
    func setupBindings() {
        
        //Listen viewModel
        viewModel.isStartActive.asObservable()
            .subscribe({ [unowned self] isActive in
                self.startButton.isEnabled = isActive.element!
            }).disposed(by: disposeBag)
        
        viewModel.locationTitle.asObservable()
            .subscribe({ [unowned self] title in
                self.enterLocationButton.setTitle(title.element!, for: .normal)
            }).disposed(by: disposeBag)
        
        //Bind interaction
        enterLocationButton.rx.tap.bind(to: viewModel.enterLocationTapped).disposed(by: disposeBag)
        startButton.rx.tap.bind(to: viewModel.startTapped).disposed(by: disposeBag)
        enterLocationButton.currentLocationButton.rx.tap.bind(to: viewModel.currentLocationTapped).disposed(by: disposeBag)
        enterLocationButton.currentLocationButton.rx.tap.subscribe({[unowned self] _ in
            self.locationManager.requestAlwaysAuthorization()
            if CLLocationManager.locationServicesEnabled() {
                self.locationManager.delegate = self
                self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                self.locationManager.startUpdatingLocation()
            }
        }).disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Decorator.decorate(self)
    }
    
    @objc private func currentLocationHandler(sender: UIButton) {
        
    }
    
    @objc private func enterLocationHandler(sender: LocationButton) {
        //StartRouter.shared.goToSelectRegionScreen(from: self)
    }
    
    @objc private func startHandler(sender: NUButton) {
        //StartRouter.shared.goToGeneralScreen(from: self)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension StartViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        self.viewModel.currentLocation.accept(Coord(lon: locValue.longitude, lat: locValue.latitude))
        locationManager.stopUpdatingLocation()
    }
}

extension StartViewController {
    fileprivate class Decorator {
        private init() {}
        
        static func decorate(_ vc: StartViewController) {
            
            vc.navigationController?.setNavigationBarHidden(true, animated: false)
            vc.drawBackground()
            
            vc.iconView.image = #imageLiteral(resourceName: "calendar.pdf")
            vc.startButton.setTitle("LET’S BEGIN", for: .normal)
            
        }
    }
}
