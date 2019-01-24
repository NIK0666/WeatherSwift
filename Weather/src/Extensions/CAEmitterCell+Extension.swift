//
//  CAEmitterCell+Extension.swift
//  Weather
//
//  Created by NIKO on 24/01/2019.
//  Copyright © 2019 NIKO. All rights reserved.
//

import UIKit

extension CAEmitterCell {
    static var snow: CAEmitterCell {
        let cell = CAEmitterCell()
        cell.birthRate = 10
        cell.lifetime = 7.0
        cell.lifetimeRange = 0
        cell.color = #colorLiteral(red: 0.9450980392, green: 0.9450980392, blue: 0.9450980392, alpha: 1).cgColor
        cell.velocity = 200
        cell.velocityRange = 50
        cell.emissionLongitude = CGFloat.pi
        cell.emissionRange = CGFloat.pi / 4
        cell.spin = 2
        cell.spinRange = 3
        cell.scale = 0.2
        cell.scaleRange = 0.1
        cell.scaleSpeed = -0.05
        cell.contents = #imageLiteral(resourceName: "snowflake.pdf").cgImage
        return cell
    }
    
    static var rain: CAEmitterCell {
        let cell = CAEmitterCell()
        cell.birthRate = 30
        cell.alphaRange = 0.5
        cell.color = #colorLiteral(red: 0.5392423272, green: 0.6809436679, blue: 1, alpha: 1).cgColor
        cell.lifetime = 3
        cell.velocity = 500
        cell.velocityRange = 50
        cell.xAcceleration = -400
        cell.yAcceleration = 400
        cell.emissionLongitude = .pi
        cell.scale = 0.15
        cell.scaleRange = 0.05
        cell.contents = #imageLiteral(resourceName: "raindrop.pdf").cgImage
        return cell
    }
}
