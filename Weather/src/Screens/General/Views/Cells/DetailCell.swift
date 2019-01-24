//
//  DetailCell.swift
//  Weather
//
//  Created by NIKO on 22/01/2019.
//  Copyright © 2019 NIKO. All rights reserved.
//

import UIKit

class DetailCell: UICollectionViewCell, NibLoadable {

    @IBOutlet private weak var temperatureLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var iconView: UIImageView!
    
    public var item: PeriodModel! {
        didSet {

            let date = Date(timeIntervalSince1970: TimeInterval(item.timestamp))
            let df = DateFormatter()
            df.timeZone = TimeZone(secondsFromGMT: 0)
            df.timeStyle = .short
            df.dateStyle = .none
            
            dateLabel.text = df.string(from: date)
            temperatureLabel.text = item.temperature
            iconView.image = UIImage(named: item.iconName)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
