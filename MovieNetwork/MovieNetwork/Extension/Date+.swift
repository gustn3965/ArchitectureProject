//
//  Date+.swift
//  MovieNetwork
//
//  Created by 박현수 on 9/3/24.
//

import Foundation

extension Date {
    
    public func dateString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        return formatter.string(from: self)
    }
}
