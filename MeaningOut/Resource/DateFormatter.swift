//
//  DateFormatter.swift
//  MeaningOut
//
//  Created by 최대성 on 6/30/24.
//

import Foundation

class DateChange {
    static let shared = DateChange()
    
    private init() {}
    
    private let dateFormatter = DateFormatter()
    
    
    func dateToString(date: Date) -> String {
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        return dateFormatter.string(from: date)
    }
    
    // String > date
    func stringToDate(string: String) -> Date? {
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        return dateFormatter.date(from: string)
    }
}
