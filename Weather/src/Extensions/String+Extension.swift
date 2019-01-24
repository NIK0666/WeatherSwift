//
//  String+Extension.swift
//  Weather
//
//  Created by NIKO on 22/01/2019.
//  Copyright © 2019 NIKO. All rights reserved.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
