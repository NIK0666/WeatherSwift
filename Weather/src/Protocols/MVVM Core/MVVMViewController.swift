//
//  MVVMViewController.swift
//  Weather
//
//  Created by NIKO on 23/01/2019.
//  Copyright © 2019 NIKO. All rights reserved.
//

import Foundation

protocol MVVMViewController: class {
    
    associatedtype ViewModelType
    
    var viewModel: ViewModelType! { get set }
    
}
