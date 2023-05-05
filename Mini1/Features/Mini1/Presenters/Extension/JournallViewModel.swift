//
//  JournalViewModel.swift
//  MiniChallenge1
//
//  Created by Silvia Pasica on 30/04/23.
//

import SwiftUI

class JournallViewModel:ObservableObject {
    @Published var currentMonth: [Date] = []
    @Published var currentDay: Date = Date()
    
    init(){
        fetchCurrentMonth()
    }
    
    func fetchCurrentMonth(){
        let today = Date()
        let calendar = Calendar.current
        let month = calendar.dateInterval(of: .month, for: today)
    
        guard let firstMonthDay = month?.start else {
            return
        }
        
        let range = calendar.range(of: .day, in: .month, for: today)!
        let dayInMonth = range.count - 1
        
        (0...dayInMonth).forEach{ day in
            if let weekday = calendar.date(byAdding: .day, value: day, to: firstMonthDay){
                currentMonth.append(weekday)
            }
        }
    }
    
    func extractDate(date: Date, format: String)->String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        
        return formatter.string(from: date)
    }
    
    func isToday(date:Date)->Bool{
        let calendar = Calendar.current
        return calendar.isDate(currentDay, inSameDayAs: date)
    }
}
