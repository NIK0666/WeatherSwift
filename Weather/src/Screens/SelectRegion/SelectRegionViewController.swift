//
//  SelectRegionViewController.swift
//  Weather
//
//  Created by NIKO on 22/01/2019.
//  Copyright © 2019 NIKO. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

protocol CitySelectedDelegate {
    func didSelectCity(_ city: City?)
}

class SelectRegionViewController: UIViewController, GradientBackgroundProtocol, MVVMViewController {

    private let disposeBag = DisposeBag()
    var viewModel: SelectRegionViewModelProtocol!
    
    @IBOutlet private weak var backButton: NUButton!
    @IBOutlet private weak var searchTextField: SearchTextField!
    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(CityCell.nib, forCellReuseIdentifier: CityCell.name)
        setupBindings()
    }
    
    private func setupBindings() {
        searchTextField.rx.text.orEmpty.bind(to: viewModel.searchText).disposed(by: disposeBag)
        backButton.rx.tap.bind(to: viewModel.cancelTapped).disposed(by: disposeBag)
        
        viewModel.cities.asObservable().bind(to:tableView.rx.items) { (tableView, row, element) in
            
            let cell = tableView.dequeueReusableCell(withIdentifier: CityCell.name) as! CityCell
            cell.city = element
            return cell
            
            }.disposed(by: disposeBag)
        
        tableView.rx.itemSelected.subscribe({ [weak self] indexPath in
            self?.viewModel.cityIndexSelected.onNext(indexPath.element!.item)
        }).disposed(by: disposeBag)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Decorator.decorate(self)
        searchTextField.becomeFirstResponder()
    }
    
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension SelectRegionViewController {
    fileprivate class Decorator {
        private init() {}
        
        static func decorate(_ vc: SelectRegionViewController) {
            vc.navigationController?.setNavigationBarHidden(true, animated: false)
            vc.drawBackground()
        }
    }
}
