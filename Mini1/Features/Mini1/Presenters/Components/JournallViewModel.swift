//
//  JournalViewModel.swift
//  MiniChallenge1
//
//  Created by Silvia Pasica on 30/04/23.
//

import SwiftUI

class JournallViewModel:ObservableObject {
        @Published var text: String = "Text"
        @Published var mood: String = "Mood"
        @Published var need: String = "Need"
        @Published var date: Date = Date.now

        @Published var feeling: [String] = ["joy", "sadness", "fear", "surprise", "anger"]
        
        let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "d"
            return formatter
        }()
        
        @Published var currentWeek: [Date] = []
        @Published var currentDay: Date = Date()
        
        init(){
            fetchCurrentWeek()
        }
        
        func showEmoji(feeling: String) -> String{
            if feeling == "love" {
               return "🥰"
            } else if feeling == "sadness" {
                return "😢"
            } else if feeling == "fear" {
                return "😨"
            } else if feeling == "surprise" {
                return "😱"
            } else if feeling == "anger" {
                return "😡"
            } else if feeling == "joy" {
                return "😆"
            } else {
                return ""
            }
        }
        
        func fetchCurrentWeek(){
            let today = Date()
            let calendar = Calendar.current
            
            let week = calendar.dateInterval(of: .weekOfMonth, for: today)
            
            
            guard let firstWeekDay = week?.start else {
                return
            }
            
            let range = calendar.range(of: .day, in: .month, for: today)!
            let dayInMonth = range.count

            (1...dayInMonth).forEach { day in
                if let weekday = calendar.date(byAdding: .day, value: day, to: firstWeekDay) {
                    currentWeek.append(weekday)
                }
            }
        }
        
        func extractedDate(date1: Date, format: String) -> String{
            let formatter = DateFormatter()
            formatter.dateFormat = format
            return formatter.string(from: date1)
        }
        
        // cheking if current date is today
        func isToday(date2: Date) -> Bool{
            let calendar = Calendar.current
            
            return calendar.isDate(currentDay, inSameDayAs: date2)
        }
}
