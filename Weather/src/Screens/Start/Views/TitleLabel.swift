//
//  TitleLabel.swift
//  Weather
//
//  Created by NIKO on 22/01/2019.
//  Copyright © 2019 NIKO. All rights reserved.
//

import UIKit

class TitleLabel: UILabel {

    override func awakeFromNib() {
        let attributedString = NSMutableAttributedString(string: "WEATHER REPORT", attributes: [NSAttributedString.Key.font : UIFont(name: "HelveticaNeue-Medium",size: 24)!])
        let reportRange = (attributedString.string as NSString).range(of: "REPORT")
        attributedString.setAttributes([NSAttributedString.Key.font : UIFont(name: "HelveticaNeue",size: 24)!], range: reportRange)
        attributedText = attributedString
    }

}
