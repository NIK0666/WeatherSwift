//
//  GradientBackgroundProtocol.swift
//  Weather
//
//  Created by NIKO on 22/01/2019.
//  Copyright © 2019 NIKO. All rights reserved.
//

import UIKit

protocol GradientBackgroundProtocol {
}

extension GradientBackgroundProtocol where Self: UIViewController {
    func drawBackground() {
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.startPoint = CGPoint(x: 0, y: 0);
        gradient.endPoint = CGPoint(x: 0.35, y: 1.25);
        gradient.colors = [#colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1).cgColor, UIColor.black.cgColor]
        view.layer.insertSublayer(gradient, at: 0)
    }
}
