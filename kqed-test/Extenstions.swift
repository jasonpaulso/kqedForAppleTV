//
//  Extenstions.swift
//  KQED_Apple_TV
//
//  Created by Jason Southwell on 1/19/17.
//  Copyright © 2017 Jason Paul Southwell. All rights reserved.
//

import Foundation

extension Double {
    /// Rounds the double to decimal places value
    func roundTo(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
