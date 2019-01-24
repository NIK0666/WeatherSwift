//
//  LocationButton.swift
//  Weather
//
//  Created by NIKO on 22/01/2019.
//  Copyright © 2019 NIKO. All rights reserved.
//

import UIKit

class LocationButton: UIButton {
    
    public var city: City? {
        didSet {
            guard let currentCity = city else {
                setTitle("ENTER LOCATION", for: .normal)
                return
            }
            setTitle(currentCity.fullLocation(), for: .normal)
        }
    }
    
    
    
    private(set) var currentLocationButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = #colorLiteral(red: 0.9450980392, green: 0.9450980392, blue: 0.9450980392, alpha: 1)
        button.setImage(#imageLiteral(resourceName: "location.pdf"), for: .normal)
        return button
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        addSubview(currentLocationButton)
        
        currentLocationButton.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        currentLocationButton.topAnchor.constraint(equalTo: topAnchor).isActive = true
        currentLocationButton.widthAnchor.constraint(equalToConstant: 44).isActive = true
        currentLocationButton.heightAnchor.constraint(equalToConstant: 38).isActive = true
        
        contentHorizontalAlignment = .left
        contentEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: currentLocationButton.frame.width + 16)
        layer.cornerRadius = frame.height / 2
        layer.borderWidth = 1
        layer.borderColor = #colorLiteral(red: 0.9450980392, green: 0.9450980392, blue: 0.9450980392, alpha: 1)
        
        currentLocationButton.setImage(#imageLiteral(resourceName: "location.pdf"), for: .normal)
        
    }
}
