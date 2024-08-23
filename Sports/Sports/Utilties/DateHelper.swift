//
//  Date.swift
//  Sporty
//
//  Created by marwa maky on 23/08/2024.
//

import Foundation
class DateHelper{
    func getCurrentDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: Date())
    }

    func getOneYearFromNowDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let oneYearFromNow = Calendar.current.date(byAdding: .year, value: 1, to: Date())!
        return formatter.string(from: oneYearFromNow)
    }

    func getOneYearAgoDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let oneYearAgo = Calendar.current.date(byAdding: .year, value: -1, to: Date())!
        return formatter.string(from: oneYearAgo)
    }

}
