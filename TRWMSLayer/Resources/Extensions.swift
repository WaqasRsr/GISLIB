//
//  Extensions.swift
//  TRWMSLayer
//
//  Created by Zuhair Hussain on 17/02/2020.
//  Copyright © 2020 Waqas Rasheed. All rights reserved.
//

import Foundation


extension String {
    func dateValue(format: String, timeZone: TimeZone? = TimeZone(abbreviation: "GMT")) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = timeZone
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter.date(from: self)
    }
}


extension Date {
    
    func stringValue(format: String, timeZone: TimeZone? = TimeZone(abbreviation: "GMT")) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = timeZone
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter.string(from: self)
    }
}
