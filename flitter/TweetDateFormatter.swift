//
//  TweetDateFormatter.swift
//  flitter
//

import Foundation

class TweetDateFormatter {
    let dateFormatter: DateFormatter
    
    init() {
        dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
    }
    
    func formatDate(since1970 timeInterval: Double) -> String {
        let date = Date(timeIntervalSince1970: timeInterval)
        return dateFormatter.string(from: date)
    }
}
