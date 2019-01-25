//
//  NUButton.swift
//  Weather
//
//  Created by NIKO on 22/01/2019.
//  Copyright © 2019 NIKO. All rights reserved.
//

import UIKit

@IBDesignable class NUButton: UIButton {
    
    @IBInspectable var borderWidth: CGFloat = 1
    @IBInspectable var borderColor: UIColor = #colorLiteral(red: 0.200000003, green: 0.200000003, blue: 0.200000003, alpha: 1)
    
    override func prepareForInterfaceBuilder() {
        styleView()
    }
    override func awakeFromNib() {
        styleView()
    }
    
    func styleView() {
        layer.cornerRadius = frame.height / 2
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
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

