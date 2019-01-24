//
//  GeneralViewController.swift
//  Weather
//
//  Created by NIKO on 22/01/2019.
//  Copyright © 2019 NIKO. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class GeneralViewController: UIViewController, GradientBackgroundProtocol {

    var viewModel: GeneralViewModelProtocol!
    
    
    @IBOutlet private weak var locationNameLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var temperatureLabel: UILabel!
    @IBOutlet private weak var statusIconView: UIImageView!
    @IBOutlet private weak var detailsCollectionView: UICollectionView!
    @IBOutlet private weak var searchButton: UIButton!
    @IBOutlet private weak var activityIndicatorView: UIActivityIndicatorView!
    
    private let particleEmitter = CAEmitterLayer()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCells()
        setupBindings()
    }
    
    func setupBindings() {
        viewModel.locationTitle.bind(to: locationNameLabel.rx.text).disposed(by: disposeBag)
        viewModel.descriptionString.bind(to: descriptionLabel.rx.text).disposed(by: disposeBag)
        viewModel.weatherIconName.asObservable().subscribe({ name in
            if let iconName = name.element! {
                self.statusIconView.image = UIImage(named: iconName)
                self.setupParticles(particleName: iconName)
            }
        }).disposed(by: disposeBag)
        viewModel.temperatureString.bind(to: temperatureLabel.rx.text).disposed(by: disposeBag)
        viewModel.currentTimeString.bind(to: dateLabel.rx.text).disposed(by: disposeBag)
        viewModel.showLoadingIndicator.asObservable().bind(to: activityIndicatorView.rx.isAnimating).disposed(by: disposeBag)
        
        //Periods list
        viewModel.periods.asObservable().bind(to: detailsCollectionView.rx.items) { (collectionView, row, element) in
            let cell = self.detailsCollectionView.dequeueReusableCell(withReuseIdentifier: DetailCell.name, for: IndexPath(row: row, section: 1)) as! DetailCell
            cell.item = element
            return cell
        }.disposed(by: disposeBag)
        detailsCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
        searchButton.rx.tap.bind(to: viewModel.searchTapped).disposed(by: disposeBag)
    }
    
    private func registerCells() {
        detailsCollectionView.register(DetailCell.nib, forCellWithReuseIdentifier: DetailCell.name)
    }
    
    func setupParticles(particleName: String) {
        particleEmitter.emitterShape = .line
        view.layer.addSublayer(particleEmitter)
        
        particleEmitter.emitterPosition = CGPoint(x: view.center.x, y: -96)
        particleEmitter.emitterSize = CGSize(width: view.frame.size.width * 2, height: 1)
        
        switch particleName{
        case "snow":
            particleEmitter.emitterCells = [CAEmitterCell.snow]
        case "rain":
            particleEmitter.emitterCells = [CAEmitterCell.rain]
        default:
            particleEmitter.emitterCells = []
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Decorator.decorate(self)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension GeneralViewController {
    fileprivate class Decorator {
        private init() {}
        
        static func decorate(_ vc: GeneralViewController) {
            vc.navigationController?.setNavigationBarHidden(true, animated: false)
            vc.drawBackground()
        }
    }
}

extension GeneralViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 64, height: 96)
    }
}
