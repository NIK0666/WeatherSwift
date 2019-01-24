//
//  NUButton.swift
//  Weather
//
//  Created by NIKO on 22/01/2019.
//  Copyright © 2019 NIKO. All rights reserved.
//

import UIKit

class NUButton: UIButton {

    override func awakeFromNib() {
        layer.cornerRadius = frame.height / 2
        layer.borderWidth = 1
        layer.borderColor = #colorLiteral(red: 0.200000003, green: 0.200000003, blue: 0.200000003, alpha: 1)
    }
    
    
    override var isEnabled: Bool {
        didSet {
            if (isEnabled) {
                alpha = 1
            } else {
                alpha = 0.3
            }
        }
    }

}
